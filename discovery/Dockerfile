FROM ubuntu:latest

RUN apt -y update && apt -y install curl iproute2

ENV COLONY_API_URL=https://colony-api-development.mgmt-20.kubefirst.com
ENV COLONY_HARDWARE_ID=2de76518-16e2-45ec-b3ae-ee8db5f4de6f

ENV K1_COLONY_API_URL=$K1_COLONY_API_URL
ENV K1_COLONY_HARDWARE_ID=$K1_COLONY_HARDWARE_ID

COPY . .

CMD [ "./entrypoint.sh" ]