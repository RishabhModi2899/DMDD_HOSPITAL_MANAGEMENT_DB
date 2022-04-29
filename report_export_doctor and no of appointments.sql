<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="77a723ec-0180-1000-8028-7f0000012739" type="" style="Table" enable="true">
	<name><![CDATA[Doctors and total number of appointments]]></name>
	<description><![CDATA[This chart is used to stream line the number of appointments the doctors get and further this data is used in scheduling the availability of doctors on a given day.]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select d.doctor_id, d.doc_first_name, d.doc_last_name, count(a.appointment_id)as No_of_appointments from doctor d
join doctor_hospital dh on d.doctor_id = dh.doctor_id 
join appointments a on a.doc_hospital_id = dh.doc_hospital_id
group by d.doctor_id, d.doc_first_name, d.doc_last_name order by d.doctor_id]]></sql>
	</query>
</display>
</displays>