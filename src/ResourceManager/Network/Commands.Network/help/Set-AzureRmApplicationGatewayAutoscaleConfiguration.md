---
external help file: Microsoft.Azure.Commands.Network.dll-Help.xml
online version: https://docs.microsoft.com/en-us/powershell/module/azurerm.network/set-azurermapplicationgatewayautoscaleconfiguration
schema: 2.0.0
---

# Set-AzureRmApplicationGatewayAutoscaleConfiguration

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Set-AzureRmApplicationGatewayAutoscaleConfiguration -ApplicationGateway <PSApplicationGateway>
 -Bounds <PSApplicationGatewayAutoscaleBounds> [-DefaultProfile <IAzureContextContainer>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> Set-AzureRmApplicationGatewayAutoscaleConfiguration -ApplicationGateway $appgw -Bounds $bounds
```

set the auto scale to appgw

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

### -Bounds
Application Gateway autoscale bounds on number of Application Gateway instance.

```yaml
Type: PSApplicationGatewayAutoscaleBounds
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### Microsoft.Azure.Commands.Network.Models.PSApplicationGateway


## OUTPUTS

### Microsoft.Azure.Commands.Network.Models.PSApplicationGateway


## NOTES

## RELATED LINKS

