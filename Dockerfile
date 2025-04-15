FROM texlive/texlive:latest

# Install Python and other dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /workspace

# Create a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements file and install Python dependencies in the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy build script
COPY build.py /usr/local/bin/build.py
RUN chmod +x /usr/local/bin/build.py

# Set entrypoint to use the Python in our virtual environment
ENTRYPOINT ["/opt/venv/bin/python", "/usr/local/bin/build.py"]