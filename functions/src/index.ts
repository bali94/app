import * as functions from "firebase-functions";
import * as express from 'express';
import * as cors from 'cors';
import { addOffer, deleteOffer, getAllOffers, getOfferById, updateOffer } from "./controllers/offersControllers";
import { addCompany, deleteCompany, getAllCompanies, getCompanyById, updateCompany } from "./controllers/companiesController";

const app = express()
app.use(cors());

app.get('/', (req, res) => res.status(200).send('Hey there'))
//OFFERS
app.post('/api/newOffer', addOffer)
app.get('/api/offers', getAllOffers)
app.get('/api/offers/:offerId', getOfferById)
app.patch('/api/offers/:offerId', updateOffer)
app.delete('/api/offers/:offerId', deleteOffer)
//COMPANY
app.post('/api/newCompany', addCompany)
app.get('/api/companies', getAllCompanies)
app.get('/api/companies/:companyId', getCompanyById)
app.patch('/api/companies/:companyId', updateCompany)
app.delete('/api/companies/:companyId', deleteCompany)


exports.app = functions.https.onRequest(app);