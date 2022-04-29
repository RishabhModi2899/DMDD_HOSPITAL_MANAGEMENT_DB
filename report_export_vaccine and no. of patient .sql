<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="77a3615b-0180-1000-8026-7f0000012739" type="" style="Chart" enable="true">
	<name><![CDATA[total number of patients who took certain vaccine]]></name>
	<description><![CDATA[Gives the total number of patient who took different types vaccine. This report is subsequently used in ordering the vaccines in demand and promoting the least performing vaccined by means of inooculation.]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[BAR_VERT_CLUST]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select vr.vaccine_id, v.vaccine_name, count(vr.patient_id) as no_of_patients from vaccine_records vr
join vaccine v on v.vaccine_id = vr.vaccine_id group by vr.vaccine_id,v.vaccine_name order by vr.vaccine_id]]></sql>
	</query>
</display>
</displays>