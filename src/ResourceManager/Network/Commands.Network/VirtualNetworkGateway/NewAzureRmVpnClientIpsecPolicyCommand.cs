// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------

using Microsoft.Azure.Commands.Network.Models;
using System;
using System.Management.Automation;
using MNM = Microsoft.Azure.Management.Network.Models;

namespace Microsoft.Azure.Commands.Network
{
    [Cmdlet(VerbsCommon.New, "AzureRmVpnClientIpsecPolicy"), OutputType(typeof(PSIpsecPolicy))]
    public class NewAzureRmVpnClientIpsecPolicyCommand : NetworkBaseCmdlet
    {
        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds")]
        [ValidateRange(300, 172799)]
        public int SALifeTime { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB")]
        [ValidateRange(1024, int.MaxValue)]
        public int SADataSize { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IPSec encryption algorithm (IKE Phase 1)")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "GCMAES256",
            "GCMAES128",
            "AES256",
            "AES128")]
        public string IpsecEncryption { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IPSec integrity algorithm (IKE Phase 1)")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "GCMAES256",
            "GCMAES128",
            "SHA256")]
        public string IpsecIntegrity { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IKE encryption algorithm (IKE Phase 2)")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "GCMAES256",
            "GCMAES128",
            "AES256",
            "AES128")]
        public string IkeEncryption { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient IKE integrity algorithm (IKE Phase 2)")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "SHA384",
            "SHA256")]
        public string IkeIntegrity { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient DH Groups used in IKE Phase 1 for initial SA")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "DHGroup24",
            "ECP384",
            "ECP256",
            "DHGroup14",
            "DHGroup2")]
        public string DhGroup { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The Vpnclient PFS Groups used in IKE Phase 2 for new child SA")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(
            "PFS24",
            "PFSMM",
            "ECP384",
            "ECP256",
            "PFS14",
            "PFS2",
            "None")]
        public string PfsGroup { get; set; }

        public override void Execute()
        {
            base.Execute();

            var vpnclientIpsecPolicy = new PSIpsecPolicy();

            // default SA values
            vpnclientIpsecPolicy.SALifeTimeSeconds = (!this.MyInvocation.BoundParameters.ContainsKey("SALifeTime")) ? 7200 : this.SALifeTime;
            vpnclientIpsecPolicy.SADataSizeKilobytes = (!this.MyInvocation.BoundParameters.ContainsKey("SADataSize")) ? 104857600 : this.SADataSize;

            vpnclientIpsecPolicy.IpsecEncryption = (!this.MyInvocation.BoundParameters.ContainsKey("IpsecEncryption")) ? "GCMAES256" : this.IpsecEncryption;
            vpnclientIpsecPolicy.IpsecIntegrity = (!this.MyInvocation.BoundParameters.ContainsKey("IpsecIntegrity")) ? "GCMAES256" : this.IpsecIntegrity;

            // GCM matching check
            if ((vpnclientIpsecPolicy.IpsecEncryption.Contains("GCM") || vpnclientIpsecPolicy.IpsecIntegrity.Contains("GCM"))
                && vpnclientIpsecPolicy.IpsecEncryption != vpnclientIpsecPolicy.IpsecIntegrity)
            {
                throw new ArgumentException("Vpnclient IpsecEncryption and IpsecIntegrity must use matching GCM algorithms");
            }

            vpnclientIpsecPolicy.IkeEncryption = (!this.MyInvocation.BoundParameters.ContainsKey("IkeEncryption")) ? "AES256" : this.IkeEncryption;
            vpnclientIpsecPolicy.IkeIntegrity = (!this.MyInvocation.BoundParameters.ContainsKey("IkeIntegrity")) ? "SHA256" : this.IkeIntegrity;
            vpnclientIpsecPolicy.DhGroup = (!this.MyInvocation.BoundParameters.ContainsKey("DhGroup")) ? "DHGroup24" : this.DhGroup;
            vpnclientIpsecPolicy.PfsGroup = (!this.MyInvocation.BoundParameters.ContainsKey("PfsGroup")) ? "PFS24" : this.PfsGroup;

            WriteObject(vpnclientIpsecPolicy);
        }
    }
}