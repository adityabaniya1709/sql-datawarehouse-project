
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
    SET @batch_start_time = GETDATE ();
    Print '=======================================';
    Print 'Loading Bronze Layer' ;
    
    Print '====================================';

    Print '-----------------------------------------';
    Print 'Loading CRM Tables';
    Print '-----------------------------------------';

    Set @start_time = GETDATE ();
    PRINT '>Truncating table bronze.crm_cust_info'
    TRUNCATE Table bronze.crm_cust_info;

    Print 'Inserting data into :bronze.crm_cust_info' 
    BULK INSERT bronze.crm_cust_info
    From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
    WITH (
    FIRSTROW = 2,
    fieldterminator =',',
    TABLOCK
    );
    Set @end_time = GETDATE ();
    PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------------------------'
   
   
   Set @start_time = GETDATE ();
    PRINT '>Truncating table bronze.crm_prd_info'
    TRUNCATE Table bronze.crm_prd_info;

       Print 'Inserting data into :bronze.crm_prd_info'
        BULK INSERT bronze.crm_prd_info
        From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
        WITH (
        FIRSTROW = 2,
        fieldterminator =',',
        TABLOCK
        );
        Set @end_time = GETDATE ();
        PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------'
    

    PRINT '>Truncating table bronze.crm_sales_details'
    TRUNCATE Table bronze.crm_sales_details;

    Set @start_time = GETDATE ();
    Print 'Inserting data into :bronze.crm_sales_details'
    BULK INSERT bronze.crm_sales_details
    From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
    WITH (
    FIRSTROW = 2,
    fieldterminator =',',
    TABLOCK
    );
    Set @end_time = GETDATE ();

    PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------------------------'





    Print '-----------------------------------------';
    Print 'Loading ERP Tables';
    Print '-----------------------------------------';
    
    
    Set @start_time = GETDATE ();
    PRINT '>Truncating table bronze.erp_CUST_AZ12'
    TRUNCATE Table bronze.erp_CUST_AZ12;

    
    Print 'Inserting data into :bronze.erp_CUST_AZ12'
    BULK INSERT bronze.erp_CUST_AZ12
    From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\CUST_AZ12.csv'
    WITH (
    FIRSTROW = 2,
    fieldterminator =',',
    TABLOCK
    );
    Set @end_time = GETDATE ();
    PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------------------------'

    Set @start_time = GETDATE ();
    PRINT '>Truncating table bronze.erp_LOC_A101'
    TRUNCATE Table bronze.erp_LOC_A101;

    Print 'Inserting data into :bronze.erp_LOC_A101'
    BULK INSERT bronze.erp_LOC_A101
    From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\LOC_A101.csv'
    WITH (
    FIRSTROW = 2,
    fieldterminator =',',
    TABLOCK
    );
    Set @end_time = GETDATE ();
    PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------------------------'

    Set @start_time = GETDATE ();
    PRINT '>Truncating table bronze.erp_PX_CAT_G1V2'
    TRUNCATE Table bronze.erp_PX_CAT_G1V2;

    Print 'Inserting data into :bronze.erp_PX_CAT_G1V2'
    BULK INSERT bronze.erp_PX_CAT_G1V2
    From 'C:\Users\ASUS\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
    FIRSTROW = 2,
    fieldterminator =',',
    TABLOCK
    );
    

    Set @end_time = GETDATE ();
    PRINT '>> LOAD DURATION: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '-------------------------------------'


    set @batch_end_time = GETDATE ();
    PRINT '============================================================='
    PRINT '>> LOADING BRONZE LAYER IS COMPLETE';
    PRINT 'Total Load Duration: ' + CAST (DATEDIFF (SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    PRINT '=============================================================='

    END TRY
    BEGIN CATCH
       PRINT '============================================='
       
       PRINT 'ERROR OCCURRED  DURING LOADING BRONZE LAYER'

       PRINT 'ERROR MESSAGE: ' + CAST (ERROR_MESSAGE () AS NVARCHAR);
       
       PRINT 'ERROR NUMBER: ' + CAST (ERROR_NUMBER () AS NVARCHAR);

       PRINT 'ERROR STATE: ' + CAST (ERROR_STATE () AS NVARCHAR);

       PRINT '============================================='
    END CATCH
end
