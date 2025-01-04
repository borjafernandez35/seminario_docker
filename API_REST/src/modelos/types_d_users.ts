import { model, Schema } from "mongoose";

export interface usersInterface{
    name: string,
    mail: string,
    password: string,
    comment: string
}
export type UsersInterfacePublicInfo = Pick<usersInterface, 'name' | 'comment'>
export type UsersInterfacePrivateInfo = Pick<usersInterface, 'mail' | 'password'>
export type newUserInfo = Omit<usersInterface,'id'>

export const usersSchema = new Schema<usersInterface>({
    name: String,
    mail: String,
    password: String,
    comment: String
})

export const usersofDB = model<usersInterface>('user',usersSchema)