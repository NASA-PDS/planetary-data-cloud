# Big Data Migration Trade Study

Per https://github.com/NASA-PDS/planetary-data-cloud/issues/126, we wanted to investigate alternative options 
to Data Upload Manager to load data into AWS faster. The 3 COTs products we investigated were:

* [AWS DataSync](aws-datasync.md)
* [AWS Snowball](aws-snowball.md)
* [IBM Aspera](ibm-aspera.md)


## Result

Due to the exhorbitant costs of many of these capabilities, we are going to proceed with using Data Upload Manager 
in most cases of data loading for the PDS. In rare cases where we must move data fast, we will go with AWS Snowball.
