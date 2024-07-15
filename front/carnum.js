const express = require('express');
const fileUpload = require('express-fileupload');
const vision = require('@google-cloud/vision');
const cors = require('cors'); // 추가된 부분
const app = express();

app.use(cors()); // 추가된 부분
app.use(fileUpload());

// 엔드포인트 정의
app.post('/carNumCheck', async (req, res) => {
	if (!req.files || !req.files.image) {
		return res.status(400).send('No files were uploaded.');
	}

	const client = new vision.ImageAnnotatorClient();
	try {
		const [result] = await client.textDetection(req.files.image.data);
		const detections = result.textAnnotations;
		if (detections.length > 0) {
			const licensePlate = detections[0].description.replace(/\s/g, '');
			res.send({ licensePlate });
		} else {
			res.status(404).send('No license plate detected.');
		}
	} catch (error) {
		console.error('Error during text detection:', error);
		res.status(500).send('Error during text detection');
	}
});

// 서버 시작
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
	console.log(`Server is running on port ${PORT}`);
});