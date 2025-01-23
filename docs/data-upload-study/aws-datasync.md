# AWS DataSync Research Report on ATLAS Data Transfer

AWS DataSync offers a **pay-as-you-go** pricing model, charging a flat
fee per gigabyte (GB) of data transferred.

-   \(1\) Data Transfer Costs:

    -   **(a) Per-Gigabyte Fee**: The current rate is **\$0.0125 per
        GB**.

    -   **(b) Total Transfer Cost (\$13,107.20 for basic mode)**

        -   \(i\) **Basic** Mode:

            -   **Limitations**:

                -   Basic Mode is subject to
                    [quotas](https://docs.aws.amazon.com/datasync/latest/userguide/datasync-limits.html)
                    on the number of files and objects in a dataset.

                -   It sequentially prepares, transfers, and verifies
                    files, making it slower than Enhanced Mode for most
                    workloads.

            -   **Cost Structure**:

                -   DataSync charges a flat rate of **\$0.0125 per GB**
                    transferred.

            -   **Calculation**:

                -   **Total Data**:

                    -   1,024TB × 1,024GB/TB = 1,048,576GB

                -   **Cost**: 

                    -   1,048,576 GB × \$0.0125/GB = \$13,107.20

        -   \(ii\) **Enhanced** Mode:

            -   **Features**:

                -   Offers higher performance by processing tasks in
                    parallel.

                -   Allows transferring virtually unlimited numbers of
                    objects between Amazon S3 locations.

                -   Currently available only for transfers between
                    Amazon S3 locations.

            -   **Cost Structure**:

                -   **Per-GB Fee**: Same as Basic Mode, at **\$0.0125
                    per GB**.

                -   **Task Execution Fee**: **\$0.55 per task
                    execution**.

            -   **Calculation**:

                -   **Assumptions**:

                    -   2 million task executions

                    -   Each task processes 500 MB of data.

                -   **Task Execution Cost**:

                    -   2,000,000 tasks × \$0.55/task = 1,100,000

                    -   \$13,107.20 (data transfer) + \$1,100,000
                        (task execution) = \$1,113,107.20

-   \(2\) **Summary**

    -   For migrating **1 PB of data** to the cloud using **AWS
        DataSync**, the primary cost is the data transfer fee, estimated
        at **\$13,107.20** in Basic Mode.

    -   Enhanced Mode offers improved performance, but incurs
        significantly higher costs due to task execution fees. For
        large-scale migrations involving many small files or objects,
        Enhanced Mode may be more efficient but much costlier.

-   \(3\) **Reference**

    -   AWS Data Sync Pricing:
        <https://aws.amazon.com/datasync/pricing/>

    -   AWS Pricing Calculator: <https://calculator.aws/#/> 
