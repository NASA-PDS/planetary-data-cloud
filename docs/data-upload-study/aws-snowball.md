# AWS Snowball Research Report on ATLAS Data Transfer

# . Order Placement and Data Tier Specification

-   **Time to Place a Snowball Order**: 4-5 days.

-   **Data Tier Options**:

    -   **Glacier**: For infrequent access and long-term archival.

    -   **S3**: For frequent access and active workflows.

# 2. Data Transfer Timelines and Capacity

-   **Transfer Volume**:

    -   80TB of data: Transfer via Snowball takes 4-5 days.

    -   1PB of data: Estimated to take approximately 24 days.

-   **Transfer Modes**:

    -   **Sequential**: Data is transferred in a linear sequence.

    -   **Parallel**: Multiple data streams are transferred
        simultaneously.

# 3. Snowball Usage and Cost Analysis

-   **Capacity Range**:

    -   For 101-210TB of data, 5 Snowballs were used if using 200TB
        snowball.

-   **Costs**:

    -   200TB snowball

        -   \$3,200 for 15 days per Snowball.

            -   Additional \$250 per day after 15 days.

    -   100TB snowball

        -   \$1,800 for 15 days per Snowball.

            -   Additional \$250 per day after 15 days.

# 4. Setup and Configuration

-   **Physical Setup**:

    -   Assign an IP address to the Snowball.

    -   Connect it to the network.

    -   Mount the device using an NFS share.

-   **Data Transfer Process**:

    -   Use a 10GB fiber or wired network for high-speed transfers.

    -   Create a share on the Snowball.

    -   Mount the share on the system.

    -   Copy data to the Snowball.

-   **AWS CLI Tool**:

    -   Use provided digital keys below to connect to the Snowball.

        -   \(1\) *manifest* key

        -   \(2\) *access* key 

    -   Perform data operations using AWS CLI commands.

# 5. On-Prem Data Copy Requirements

-   **Connection Requirements**:

    -   Fiber or wired network capable of gigabit speeds.

    -   Assign an IP address to the Snowball device.

    -   Provide credentials for on-prem access.

-   **Responsibilities**:

    -   Handle data copy to the Snowball.

    -   Perform verification to ensure successful data transfer.

# 6. Additional Notes

-   **Network and Mounting**:

    -   Ensure the same network for Snowball and data systems.

    -   Configure NFS share for efficient data transfer.

