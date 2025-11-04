#FROM python:latest

#RUN apt-get update -y && apt-get upgrade -y \
   # && apt-get install -y #--no-install-recommends ffmpeg curl unzip \
   # && apt-get clean \
  #  && rm -rf /var/lib/apt/lists/*

#RUN curl -fsSL https://deno.land/install.sh | #sh \
   # && ln -s /root/.deno/bin/deno /usr/local/#bin/deno

#RUN pip3 install -U pip && pip3 install -U -r #requirements.txt
#CMD ["bash", "start"]



FROM python:3.11-slim

# System dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ffmpeg curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Deno install
RUN curl -fsSL https://deno.land/install.sh | sh \
    && ln -s /root/.deno/bin/deno /usr/local/bin/deno

# Copy requirements first for better layer caching
WORKDIR /app
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install -U pip && pip3 install -U -r requirements.txt

# Copy application code
COPY . .

CMD ["bash", "start"]
