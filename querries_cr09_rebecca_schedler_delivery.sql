Possible Querries for the Postal DATABASE

1.) Shows the full address and delivery request of each recipient

SELECT recipient.last_name, recipient.first_name, r_address.street_name, r_address.house_number, r_address.zip, r_address.city_name, r_address.country, delivery_request.request_description 
FROM recipient 
INNER JOIN r_address ON r_address.r_address_id = recipient.fk_r_address_id
INNER JOIN delivery_request ON delivery_request.delivery_request_id = recipient.fk_request_id;


2.) Shows all "foreign" Mail in the database

Select recipient.last_name, mail.shipment_type, delivery_process.send_time
FROM delivery_process
INNER JOIN recipient ON delivery_process.fk_recipient_id = recipient.recipient_id
INNER JOIN mail ON delivery_process.fk_mail_id = mail.mail_id
where mail.shipment_type = "foreign"

3.) Shows all mail with the status "on the road"

Select recipient.last_name, delivery_status.status_description, delivery_process.send_time
FROM delivery_process
INNER JOIN recipient ON delivery_process.fk_recipient_id = recipient.recipient_id
INNER JOIN delivery_status ON delivery_process.fk_status_id = delivery_status.status_id
where delivery_status.status_description = "mail on the road";

4.) Shows all employees with their place of work
SELECT * 
FROM postal_employee
INNER JOIN postal_office ON postal_employee.fk_po_id = postal_office.po_id;

5.) Shows only employees of the postal shop Tannenweg

SELECT * 
FROM postal_employee
INNER JOIN postal_office ON postal_employee.fk_po_id = postal_office.po_id
INNER JOIN po_address ON postal_office.fk_po_address_id = po_address.po_address_id
where po_address.street_name = "Tannenweg";

6.) Shows send_dates and sender_names after the 07.07.2020

SELECT * 
FROM sender
INNER JOIN delivery_process ON delivery_process.fk_sender_id = sender.sender_id
where delivery_process.send_time > "2020-07-07";





