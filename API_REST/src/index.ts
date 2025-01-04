import express,{RequestHandler} from 'express'
import cors from 'cors'
import userRouter from './routes/user'
import experienciasRouter from './routes/experiencias'
import { run } from './database/mongo_conn'

const app = express()
app.use(express.json())
run();

app.use(cors());
app.use(express.json() as RequestHandler);

const PORT = 3000;

app.get('/ping', (_req , res) => {
    console.log('ping recivido correctamente')
    res.send('pinged Flutter')
})

app.use('/user',userRouter)
app.use('/experiencias',experienciasRouter)

app.listen(PORT, () => {
    console.log('el servidor esta escuchando en el puerto '+ PORT)
})