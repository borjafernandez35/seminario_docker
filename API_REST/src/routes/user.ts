import express from 'express'
import * as userServices from '../services/userServices'
import { logIn } from '../controllers/user_controller'

//import toNewUser from '../extras/utils'

const router = express.Router()

router.get('/', async(_req, res) => {
    const data = await userServices.getEntries.getAll()
    return res.json(data);
})

router.get('/:id', async(req, res) => {
    const data = await userServices.getEntries.findById(req.params.id)
    return res.json(data);
})

router.post('/newUser', async(req, res) => {
    const data = await userServices.getEntries.create(req.body)
    return res.json(data);
})

router.post('/logIn', logIn)

router.post('/addExperiencias/:idUser/:idExp', async(req, res) => {
    const data = await userServices.getEntries.addExperiencies(req.params.idUser,req.params.idExp)
    return res.json(data);
})

router.put('/:id', async(req, res) => {
    const data = await userServices.getEntries.update(req.params.id,req.body)
    return res.json(data);
})

router.delete('/:id', async(req, res) => {
    const data = await userServices.getEntries.delete(req.params.id)
    return res.json(data);
})

router.delete('/delParticipant/:idUser/:idExp', async(req, res) => {
    const data = await userServices.getEntries.delExperiencies(req.params.idUser,req.params.idExp)
    return res.json(data);
})


export default router