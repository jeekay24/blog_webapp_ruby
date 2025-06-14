# Install required packages and clean up
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /myapp

# Copy and install gems first (better caching)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Fix permissions for logs and other Rails directories
RUN mkdir -p log tmp && \
    chmod -R 755 log tmp && \
    touch log/development.log && \
    chmod 664 log/development.log

# Expose port
EXPOSE 3000

# Start the Rails server (this will be overridden by docker-compose)
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
