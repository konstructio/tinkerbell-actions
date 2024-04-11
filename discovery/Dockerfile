FROM ubuntu:latest

RUN apt -y update && apt -y install curl iproute2

ENV COLONY_API_URL=https://colony-api-development.mgmt-20.kubefirst.com
ENV COLONY_HARDWARE_ID=2de76518-16e2-45ec-b3ae-ee8db5f4de6f

COPY . .

CMD [ "./entrypoint.sh" ]