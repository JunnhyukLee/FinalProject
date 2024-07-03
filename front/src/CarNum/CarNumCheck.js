import React, { useState } from 'react';
import axios from 'axios';

const CarNumCheck = () => {
    const [textAnnotations, setTextAnnotations] = useState([]);
    const [error, setError] = useState(null);

    const detectText = async () => {
        try {
            const response = await axios.post('http://localhost:3001/api/detectText', {
                imagePath: 'D:/study/project/carNum/608c2260bf608a1dbb09ebf4cdc07174.jpg', // 공개적으로 접근 가능한 이미지 URL
            });
            setTextAnnotations(response.data);
        } catch (error) {
            console.error('Error detecting text:', error);
            setError(error.toString());
        }
    };

    return (
        <div>
            <button onClick={detectText}>Detect Text</button>
            {error && <p>Error: {error}</p>}
            {textAnnotations.length > 0 && (
                <div>
                    <h3>Text:</h3>
                    <ul>
                        {textAnnotations.map((annotation, index) => (
                            <li key={index}>{annotation.description}</li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
};

export default CarNumCheck;
