﻿// ----------------------------------------------------------------------------------
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

using Hyak.Common;
using Microsoft.Azure.Commands.HDInsight.Commands;
using Microsoft.Azure.Commands.HDInsight.Models;
using Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters;
using Microsoft.WindowsAzure.Commands.Common;
using System.Linq;
using System.Management.Automation;

namespace Microsoft.Azure.Commands.HDInsight
{
    [Cmdlet("Get", ResourceManager.Common.AzureRMConstants.AzureRMPrefix + "HDInsightJob"),OutputType(typeof(AzureHDInsightJob))]
    public class GetAzureHDInsightJobCommand : HDInsightCmdletBase
    {
        #region Input Parameter Definitions
        [Parameter(Mandatory = true,
            Position = 0,
            HelpMessage = "The name of the cluster.")]
        public string ClusterName
        {
            get { return _clusterName; }
            set { _clusterName = value; }
        }

        [Parameter(Mandatory = true,
            Position = 1,
            HelpMessage = "The credentials with which to connect to the cluster.")]
        [Alias("ClusterCredential")]
        public PSCredential HttpCredential
        {
            get
            {
                return _credential == null
                    ? null
                    : new PSCredential(_credential.Username, _credential.Password.ConvertToSecureString());
            }
            set
            {
                _credential = new BasicAuthenticationCloudCredentials
                {
                    Username = value.UserName,
                    Password = value.Password.ConvertToString()
                };
            }
        }

        [Parameter(Position = 2,
            HelpMessage = "The JobID of the jobDetails to stop.")]
        public string JobId { get; set; }

        [Parameter(HelpMessage = "Gets or sets the number of jobs to retrieve.")]
        public int NumOfJobs { get; set; }

        [Parameter(HelpMessage = "Gets or sets the name of the resource group.")]
        [ResourceGroupCompleter]
        public string ResourceGroupName { get; set; }

        #endregion

        public override void ExecuteCmdlet()
        {
            if (ResourceGroupName == null)
            {
                ResourceGroupName = GetResourceGroupByAccountName(ClusterName);
            }

            _clusterName = GetClusterConnection(ResourceGroupName, ClusterName);

            if (NumOfJobs > 0)
            {
                var jobs = HDInsightJobClient.ListJobsAfterJobId(JobId, NumOfJobs).Select(job => new AzureHDInsightJob(job.Detail, HDInsightJobClient.ClusterName));
                WriteObject(jobs, true);
            }
            else if (JobId != null)
            {
                var job = HDInsightJobClient.GetJob(JobId);
                var jobDetails = new AzureHDInsightJob(job.JobDetail, HDInsightJobClient.ClusterName);
                WriteObject(jobDetails);
            }
            else
            {
                var jobs = HDInsightJobClient.ListJobs().Select(job => job.Id);
                WriteObject(jobs, true);
            }
        }
    }
}
