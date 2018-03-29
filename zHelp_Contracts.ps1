NAME
    Get-AtwsContract

SYNOPSIS
    This function get one or more Contract through the Autotask Web Services API.


SYNTAX
    Get-AtwsContract -filter <String[]> [-GetReferenceEntityById <String>] [<CommonParameters>]

    Get-AtwsContract [-GetReferenceEntityById <String>] [-UserDefinedField <UserDefinedField>] [-id <Int64[]>]
    [-AccountID <Int32[]>] [-BillingPreference <String[]>] [-Compliance <Boolean[]>] [-ContactName <String[]>]
    [-ContractCategory <String[]>] [-ContractName <String[]>] [-ContractNumber <String[]>] [-ContractPeriodType
    <String[]>] [-ContractType <String[]>] [-IsDefaultContract <Boolean[]>] [-Description <String[]>] [-EndDate
    <DateTime[]>] [-EstimatedCost <Double[]>] [-EstimatedHours <Double[]>] [-EstimatedRevenue <Double[]>]
    [-OverageBillingRate <Double[]>] [-StartDate <DateTime[]>] [-Status <String[]>] [-ServiceLevelAgreementID
    <String[]>] [-SetupFee <Double[]>] [-PurchaseOrderNumber <String[]>] [-TimeReportingRequiresStartAndStopTimes
    <String[]>] [-OpportunityID <Int32[]>] [-RenewedContractID <Int64[]>] [-SetupFeeAllocationCodeID <Int64[]>]
    [-ExclusionContractID <Int64[]>] [-InternalCurrencyOverageBillingRate <Double[]>] [-InternalCurrencySetupFee
    <Double[]>] [-ContactID <Int32[]>] [-NotEquals <String[]>] [-IsNull <String[]>] [-IsNotNull <String[]>]
    [-GreaterThan <String[]>] [-GreaterThanOrEquals <String[]>] [-LessThan <String[]>] [-LessThanOrEquals <String[]>]
    [-like <String[]>] [-notlike <String[]>] [-BeginsWith <String[]>] [-EndsWith <String[]>] [-contains <String[]>]
    [-IsThisDay <String[]>] [<CommonParameters>]

    Get-AtwsContract [-All] [<CommonParameters>]


DESCRIPTION
    This function creates a query based on any parameters you give and returns any resulting objects from the Autotask
    Web Services Api. By default the function returns any objects with properties that are Equal (-eq) to the value of
    the parameter. To give you more flexibility you can modify the operator by using -NotEquals [ParameterName[]],
    -LessThan [ParameterName[]] and so on.

    Possible operators for all parameters are:
     -NotEquals
     -GreaterThan
     -GreaterThanOrEqual
     -LessThan
     -LessThanOrEquals

    Additional operators for [String] parameters are:
     -like (supports * or % as wildcards)
     -notlike
     -BeginsWith
     -EndsWith
     -contains

    Properties with picklists are:

    BillingPreference
     1 - Immediately without review
     2 - Manually
     3 - On timesheet approval

    ContractCategory
     1 - Standard
     2 - Custom
     3 - NetGuard
     4 - Maintenance
     5 - Hardware-as-a-Service
     6 - Remote Backup Service
     7 - Remote Monitoring
     8 - Web Hosting
     9 - Exchange Hosting
     10 - Exchange Defender
     11 - AntiVirus Services
     12 - Domain Registration
     13 - NetShield
     14 - Software As A Service (SaaS)
     15 - NetWatch

    ContractPeriodType
     m - Monthly
     q - Quarterly
     s - Semi-Annually
     y - Yearly

    ContractType
     1 - Time & Materials
     3 - Fixed Price
     4 - Block Hours
     6 - Retainer
     7 - Recurring Service
     8 - Per Ticket

    Status
     0 - Inactive
     1 - Active

    ServiceLevelAgreementID
     1 - Standard Technical Support
     2 - No SLA

    TimeReportingRequiresStartAndStopTimes
     1 - TRUE
     0 - FALSE

    Entities that have fields that refer to the base entity of this CmdLet:

    ContractFactor
     ContractServiceAdjustment
     Contract
     ContractExclusionAllocationCode
     ContractService
     BillingItem
     ContractNote
     Project
     ContractMilestone
     InstalledProduct
     ContractServiceUnit
     ContractServiceBundleAdjustment
     ContractTicketPurchase
     Ticket
     ContractExclusionRole
     ContractCost
     ContractBlock
     AccountToDo
     TimeEntry
     PurchaseOrderItem
     ContractRetainer
     ContractRoleCost
     ContractServiceBundle
     ContractServiceBundleUnit
     ContractRate


RELATED LINKS
    New-AtwsContract
    Set-AtwsContract

REMARKS
    To see the examples, type: "get-help Get-AtwsContract -examples".
    for more information, type: "get-help Get-AtwsContract -detailed".
    for technical information, type: "get-help Get-AtwsContract -full".
    for online help, type: "get-help Get-AtwsContract -online"