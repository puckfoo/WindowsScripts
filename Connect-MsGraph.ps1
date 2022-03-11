

Install-Module -Name Microsoft.Graph


Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

$user = Get-MgUser -Filter "displayName eq 'Richard Holland'"

$user.DisplayName


Get-MgUserJoinedTeam -UserId $user.Id


Get-MgTeamChannel -TeamId $team.Id
$channel = Get-MgTeamChannel -TeamId ID_FROM_PREVIOUS_STEP -Filter "displayName eq 'General'"


Disconnect-MgGraph



https://docs.microsoft.com/en-us/graph/aad-advanced-queries?tabs=http



https://docs.microsoft.com/en-us/graph/aad-advanced-queries?tabs=http