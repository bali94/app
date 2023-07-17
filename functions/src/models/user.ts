import { Offer } from "./offer"

type User = {
    address:string
     bio:string
    dateOfBirth:string
     valid:Boolean
   photoUrl:string
    email:string
    displayName:string
   notificationToken:string
    id:string
    sort:Number
   yourResume:string
    tags:string[]
    yourFavoritesOffers:Offer[]
    offersYouAppliedTo:Offer[]
}
export { User }
