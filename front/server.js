const express = require('express');
const { ImageAnnotatorClient } = require('@google-cloud/vision');
const cors = require('cors');
const app = express();
const port = 3001;

const client = new ImageAnnotatorClient({
    keyFilename: 'D:/study/project/totemic-stack-427602-c1-688642a1637e.json', // 서비스 계정 키 파일 경로
});

app.use(cors());
app.use(express.json());

app.post('/api/detectText', async (req, res) => {
    const { imagePath } = req.body;
    try {
        const [result] = await client.textDetection(imagePath);
        const annotations = result.textAnnotations;
        res.status(200).send(annotations);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
