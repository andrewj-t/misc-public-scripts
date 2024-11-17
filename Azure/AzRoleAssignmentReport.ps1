# Get RBAC Assignments from All Subscriptions

# Process subscriptions
$AllRoleAssignments = @()
$Subscriptions = Get-AzSubscription
foreach ($Subscription in $Subscriptions) {
    Write-Host "Processing subscription: $($Subscription.Name)" -ForegroundColor Cyan
    Set-AzContext -SubscriptionId $Subscription.Id | Out-Null
    $RoleAssignments = Get-AzRoleAssignment
    $AllRoleAssignments += $RoleAssignments
}

# Remove Duplicates by RoleAssignmentId that can come from ManagementGroupAssignments
$AllRoleAssignments = $AllRoleAssignments | Sort-Object RoleAssignmentId -Unique

$AllRoleAssignments.Count


# $AllRoleAssignments | Export-Excel -Path .\AzRoleAssignment.xlsx