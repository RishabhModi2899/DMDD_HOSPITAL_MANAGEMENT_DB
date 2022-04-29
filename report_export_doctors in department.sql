<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="779e6aa4-0180-1000-8021-7f0000012739" type="" style="Table" enable="true">
	<name><![CDATA[total no. of doctors in a department]]></name>
	<description><![CDATA[Gives total number of doctors in  a department. Which is used to further improve the efficiency of the hospital by optimizing the cost involved in appointing or firing a doctor based on his record.]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[Select dt.dept_name, count(d.doctor_id) as no_of_doctors from doctor d 
join doctor_hospital dh on dh.doctor_id = d.doctor_id
join hospital_dept hd on hd.hos_dept_id = dh.hos_dept_id
join departments dt on dt.dept_id = hd.dept_id group by dt.dept_name order by dt.dept_name]]></sql>
	</query>
</display>
</displays>