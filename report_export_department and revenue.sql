<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="77abab89-0180-1000-802c-7f0000012739" type="" style="Chart" enable="true">
	<name><![CDATA[Department and revenue]]></name>
	<description><![CDATA[This report produces the overall revenue of each and every department. This report has the potential to make use of the revenue and improve the quality of under performing departments by means of infrastructure and increase revenue.]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[BAR_VERT_CLUST]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select dt.dept_id, dt.dept_name, sum(b.amount) as revenue from departments dt
join hospital_dept hd on dt.dept_id = hd.dept_id 
join doctor_hospital dh on dh.hos_dept_id = hd.hos_dept_id
join appointments a on a.doc_hospital_id = dh.doc_hospital_id 
join billing b on b.appointment_id = a.appointment_id group by dt.dept_id, dt.dept_name order by dt.dept_id]]></sql>
	</query>
</display>
</displays>