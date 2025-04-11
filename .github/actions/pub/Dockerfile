FROM dart:latest

RUN pwd

# RUN echo "Files in current directory:" && ls -la .

COPY . /

RUN chmod +x /entrypoint.sh

# RUN echo "Files after COPY:" && ls -la /

ENTRYPOINT ["/entrypoint.sh"]