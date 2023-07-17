 
import { Response } from 'express'
import { db } from '../config/firebase'
import { Offer } from '../models/offer'



type Request = {
    body: Offer,
    params: { offerId: string }
}
const addOffer = async (req: Request, res: Response) => {
    const { 
        title,
        type,
         category,
         description,
         timestamp,
         company,
         remark,
        isFavourite,
         yourProfile,
         whatWeOffer,
         tasks,
         appliers} = req.body
    try {
        const entry = db.collection('offers').doc()
        const entryObject = {
            id: entry.id,
            title,
            type,
             category,
             description,
             timestamp,
             company,
             remark,
            isFavourite,
             yourProfile,
             whatWeOffer,
             tasks,
             appliers
        }
        entry.set(entryObject)
        res.status(200).send({
            status: 'success',
            offer: 'offer added successfuly',
            data: entryObject
        })
    } catch (error) {
        res.status(500).json(error)
    }
}
const getAllOffers = async (req: Request, res: Response) => {
  try {
      const allOffers : Offer[] = []
      const querySnapshot = await db.collection('offers').get()
      querySnapshot.forEach((doc: any) => allOffers.push(doc.data()));
      res.status(200).json(allOffers)
  } catch (error) {
      res.status(500).json(error)
  }
}
const updateOffer = async (req: Request, res: Response) => {
  const { body: { 
    title,
    type,
     category,
     description,
     timestamp,
     company,
     remark,
    isFavourite,
     yourProfile,
     whatWeOffer,
     tasks,
     appliers} , params: {offerId}} = req
  try {
      const offer = db.collection('offers').doc(offerId)
      const currentData = (await offer.get()).data() || {}
      const obj = {
        id: currentData.id,
        title: title || currentData.title,
        description: description || currentData.description,
        category: category || currentData.category,
        type: type || currentData.type,
        timestamp: timestamp || currentData.timestamp,
        company: company || currentData.company,
        remark: remark || currentData.remark,
        isFavourite: isFavourite || currentData.isFavourite,
        yourProfile: yourProfile || currentData.yourProfile,
        whatWeOffer: whatWeOffer || currentData.whatWeOffer,
        tasks: tasks || currentData.tasks,
        appliers: appliers || currentData.appliers,    
      }
      await offer.set(obj)
       res.status(200).json({
          status: 'success',
          offer: 'offer updated successfuly',
          data: obj
      })
      
  } catch (error) {
      res.status(500).json(error)
  }
}

const deleteOffer = async (req: Request, res: Response) => {
  const {offerId} = req.params
  try {
      const offer = db.collection('offers').doc(offerId)
      await offer.delete()
       res.status(200).json({
          status: 'success',
          offer: 'deleted successfuly',
      })

  } catch (error) {
      res.status(500).json(error)
  }
}
const getOfferById = async (req: Request, res: Response) => {
    try {
        const offer = await db.collection('Services').doc(req.params.offerId).get()
        const doc = offer.data();
        res.status(200).json(doc)
    } catch (error) {
        res.status(500).json(error)
    }
  }
export { addOffer , getAllOffers, deleteOffer , updateOffer,getOfferById }
 