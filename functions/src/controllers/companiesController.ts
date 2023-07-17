 
import { Response } from 'express'
import { db } from '../config/firebase'
import { Company } from '../models/company'




type Request = {
    body: Company,
    params: { companyId: string }
}
const addCompany = async (req: Request, res: Response) => {
    const { 
        name,
        website,
        yearIncome,
        employees,
        postCode,
        street,
        homeNumber,
        city,
        email,
        longitude,
        latitude,
        phone,
        imageUrl,
        stars,
        fullAddress,
        description,
        comments} = req.body
    try {
        const entry = db.collection('companies').doc()
        const entryObject = {
            id: entry.id,
            name,
        website,
        yearIncome,
        employees,
        postCode,
        street,
        homeNumber,
        city,
        email,
        longitude,
        latitude,
        phone,
        imageUrl,
        stars,
        fullAddress,
        description,
        comments
        }
        entry.set(entryObject)
        res.status(200).send({
            status: 'success',
            Company: 'Company added successfuly',
            data: entryObject
        })
    } catch (error) {
        res.status(500).json(error)
    }
}
const getAllCompanies = async (req: Request, res: Response) => {
  try {
      const allCompanies : Company[] = []
      const querySnapshot = await db.collection('companies').get()
      querySnapshot.forEach((doc: any) => allCompanies.push(doc.data()));
      res.status(200).json(allCompanies)
  } catch (error) {
      res.status(500).json(error)
  }
}
const updateCompany = async (req: Request, res: Response) => {
  const { body: { 
    name,
    website,
    yearIncome,
    employees,
    postCode,
    street,
    homeNumber,
    city,
    email,
    longitude,
    latitude,
    phone,
    imageUrl,
    stars,
    fullAddress,
    description,
    comments} , params: {companyId}} = req
  try {
      const company = db.collection('companies').doc(companyId)
      const currentData = (await company.get()).data() || {}
      const obj = {
        id: currentData.id,
        name: name || currentData.name,
        description: description || currentData.description,
        website: website || currentData.website,
        yearIncome: yearIncome || currentData.yearIncome,
        employees: employees || currentData.employees,
        postCode: postCode || currentData.postCode,
        street: street || currentData.street,
        homeNumber: homeNumber || currentData.homeNumber,
        city: city || currentData.city,
        email: email || currentData.email,
        longitude: longitude || currentData.longitude,
        latitude: latitude || currentData.latitude,
        phone: phone || currentData.phone,
        imageUrl: imageUrl || currentData.imageUrl,
        stars: stars || currentData.stars,
        fullAddress: fullAddress || currentData.fullAddress,
        comments: comments || currentData.comments,
        
      }
      await company.set(obj)
       res.status(200).json({
          status: 'success',
          company: 'company updated successfuly',
          data: obj
      })
      
  } catch (error) {
      res.status(500).json(error)
  }
}

const deleteCompany = async (req: Request, res: Response) => {
  const {companyId} = req.params
  try {
      const Company = db.collection('companies').doc(companyId)
      await Company.delete()
       res.status(200).json({
          status: 'success',
          Company: 'deleted successfuly',
      })

  } catch (error) {
      res.status(500).json(error)
  }
}
const getCompanyById = async (req: Request, res: Response) => {
    try {
        const cpny = await db.collection('Services').doc(req.params.companyId).get()
        const doc = cpny.data();
        res.status(200).json(doc)
    } catch (error) {
        res.status(500).json(error)
    }
  }
export { addCompany , getAllCompanies, deleteCompany , updateCompany,getCompanyById }
 