import { Company } from "./company"
import { User } from "./user"

type Offer = {
    id:string;
 title:Number;
 type:string;
  category:string;
  description:string;
  timestamp:string;
  company:Company;
  remark:string;
 isFavourite:Boolean;
  yourProfile:string[];
  whatWeOffer:string[];
  tasks:string[];
  appliers:User[];
}
export { Offer }
