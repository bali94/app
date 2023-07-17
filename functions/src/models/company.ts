import { Comment } from "./comment"

type Company = {
name:string
website:string
yearIncome:string
employees:Number
postCode:string
street:string
homeNumber:string
city:string
email:string
longitude:Number
latitude:Number
phone:string
imageUrl:string
stars:Number
fullAddress:string
description: string
comments: Comment[]
}

export { Company }
