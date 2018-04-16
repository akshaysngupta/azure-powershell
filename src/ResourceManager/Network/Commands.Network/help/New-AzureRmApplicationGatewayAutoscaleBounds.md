---
external help file: Microsoft.Azure.Commands.Network.dll-Help.xml
online version: https://docs.microsoft.com/en-us/powershell/module/azurerm.network/new-azurermapplicationgatewayautoscalebounds
schema: 2.0.0
---

# New-AzureRmApplicationGatewayAutoscaleBounds

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
New-AzureRmApplicationGatewayAutoscaleBounds [-Min <Int32>] [-Max <Int32>]
 [-DefaultProfile <IAzureContextContainer>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> $bound = New-AzureRmApplicationGatewayAutoscaleBounds -Min 2 -Max 3
```

Create bound object.

## PARAMETERS

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

### -Max
Upper bound on number of Application Gateway instances.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Min
Lower bound on number of Application Gateway instances.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayAutoscaleBounds


## NOTES

## RELATED LINKS

