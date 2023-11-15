# Use Python 3.6 as a base image
# Copy contents into image
# Install pip dependencies from requirements
# Set YOUR_NAME environment variable
# Expose the correct port
# Create an entrypoint


FROM python:3.6

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5500

ENV YOUR_NAME="Paul"

ENTRYPOINT [ "python", "app.py" ]