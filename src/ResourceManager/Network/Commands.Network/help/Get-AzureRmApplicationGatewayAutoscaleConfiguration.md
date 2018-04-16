---
external help file: Microsoft.Azure.Commands.Network.dll-Help.xml
online version: https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermapplicationgatewayautoscaleconfiguration
schema: 2.0.0
---

# Get-AzureRmApplicationGatewayAutoscaleConfiguration

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Get-AzureRmApplicationGatewayAutoscaleConfiguration -ApplicationGateway <PSApplicationGateway>
 [-DefaultProfile <IAzureContextContainer>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> $autos = Get-AzureRmApplicationGatewayAutoscaleConfiguration -ApplicationGateway $appgw
```

Get auto scale{{ Add example description here }}

## PARAMETERS

### -ApplicationGateway
The applicationGateway

```yaml
Type: PSApplicationGateway
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: IAzureContextContainer
Parameter Sets: (All)
Aliases: AzureRmContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### Microsoft.Azure.Commands.Network.Models.PSApplicationGateway


## OUTPUTS

### Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayAutoscaleConfiguration


## NOTES

## RELATED LINKS

