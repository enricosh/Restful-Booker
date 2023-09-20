@Library('jenkins-sharedlib@master')
@Library('testing-jenkins-sharedlib')

import sharedlib.JenkinsfileUtil
import sharedlib.testing.MavenFunctionalTest

def recipients = ''
def project = "INCT"
def environment = "cert"
def slave = "pinctsop33-lnx-jenkins-slave"
def hashicorpEnabled = true

def utilsTesting = new MavenFunctionalTest(this)
def scenarios = ""
def browserDriver = ""
def type = ""

try {
    node {
        stage("Preparation") {
            utilsTesting.notifyByMail('START', recipients)
            scenarios = params.TAGS
            browserDriver = params.NAVEGADOR
            type = params.TIPO_DE_PRUEBA
            checkout scm
            utilsTesting.prepare(type, scenarios, browserDriver)
            env.project = project
            utilsTesting.setHashicorpVaultEnabled(hashicorpEnabled)
            utilsTesting.setHashicorpVaultEnvironment(environment)
            utilsTesting.setTestEnvironment(environment)
            utilsTesting.setLinuxServerTest(slave)
        }
        stage("Build") {
            utilsTesting.buildMaven()
        }
        stage("Test") {
            utilsTesting.setUseApiCredentials(true)
            utilsTesting.setBrowserDriver(browserDriver)
            utilsTesting.setUseJiraCredentials(true)
            utilsTesting.executeFunctionalTest(scenarios, type)
        }
        stage("Post Execution") {
            utilsTesting.executePostExecutionTasks()
            utilsTesting.notifyByMail('SUCCESS', recipients)
        }
    }
} catch (Exception e) {
    node {
        utilsTesting.executeOnErrorExecutionTasks()
        utilsTesting.notifyByMail('FAIL', recipients)
        throw e
    }
}