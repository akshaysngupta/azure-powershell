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

namespace Microsoft.Azure.Commands.Scheduler.Cmdlets
{
    using System;
    using System.Management.Automation;
    using Microsoft.Azure.Commands.Scheduler.Models;
    using Microsoft.Azure.Commands.Scheduler.Properties;
    using Microsoft.Azure.Commands.Scheduler.Utilities;
    using ResourceManager.Common.ArgumentCompleters;

    /// <summary>
    /// Gets job history.
    /// </summary>
    [Cmdlet("Get", ResourceManager.Common.AzureRMConstants.AzureRMPrefix + "SchedulerJobHistory"), OutputType(typeof(PSJobHistory))]
    public class GetAzureSchedulerJobHistoryCommand : SchedulerBaseCmdlet
    {
        [Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true, HelpMessage = "The targeted resource group for job.")]
        [ResourceGroupCompleter]
        [ValidateNotNullOrEmpty]
        public string ResourceGroupName { get; set; }

        [Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true, HelpMessage = "The name of the job collection.")]
        [Alias("Name", "ResourceName")]
        [ValidateNotNullOrEmpty]
        public string JobCollectionName { get; set; }

        [Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true, HelpMessage = "The name of the job.")]
        [ValidateNotNullOrEmpty]
        public string JobName { get; set; }

        [Parameter(Mandatory = false, ValueFromPipelineByPropertyName = true, HelpMessage = "The execution status of the job.")]
        [ValidateNotNullOrEmpty]
        [ValidateSet(Constants.JobCompleted, Constants.JobFailed, Constants.JobPostponed, IgnoreCase = true)]
        public string JobExecutionStatus { get; set; }

        /// <summary>
        /// Executes the command.
        /// </summary>
        public override void ExecuteCmdlet()
        {
            base.ExecuteCmdlet();

            this.WriteObject(
                            this.SchedulerClient.GetJobHistory(this.ResourceGroupName, this.JobCollectionName, this.JobName, this.JobExecutionStatus),
                            enumerateCollection: true);
        }
    }
}
