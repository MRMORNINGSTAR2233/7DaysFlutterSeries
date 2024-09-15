import requests
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from pymongo import MongoClient
import base64
import os
from bson import Binary

# MongoDB connection setup
client = MongoClient("Enter your api key here")

db = client.mydatabase
collection = db.images

app = FastAPI()

class ImageRequest(BaseModel):
    image_base64: str
    prompt: str

@app.post("/save_image/")
async def save_image(request: ImageRequest):
    try:
        # Decode the base64 image
        image_data = base64.b64decode(request.image_base64)

        # Save image and prompt to MongoDB
        collection.insert_one({
            "prompt": request.prompt,
            "image_data": request.image_base64
        })

        return {"message": "Image saved successfully!"}
    except Exception as e:
        return {"error": str(e)}

# Run the server
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
