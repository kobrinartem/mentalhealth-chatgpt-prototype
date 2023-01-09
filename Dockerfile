FROM python:3.8

COPY requirements.txt .
# Install the dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the application code to the container
COPY app /app

WORKDIR /app/

# Run the Streamlit app
CMD streamlit run app.py
