import { usersInterface, UsersInterfacePrivateInfo } from '../modelos/types_d_users'
import * as userServices from '../services/userServices'
import { Request, Response } from 'express'


export async function logIn(req:Request,res:Response):Promise<Response> {
    try{
        const { mail,password } = req.body as UsersInterfacePrivateInfo;
        const user:usersInterface|null = await userServices.getEntries.findIdAndPassword(mail, password);
        console.log("Logeao:",user);
        if (user!=null){
            return res.status(200).json(user);
        } else {
            return res.status(400).json({message:'User or password incorrect'})
        }
    } catch(e){
        return res.status(500).json({ e: 'Failed to find user' });
    }
}