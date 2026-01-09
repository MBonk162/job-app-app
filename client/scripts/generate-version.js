import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

try {
  // Get git commit info
  const commitHash = execSync('git log -1 --format="%h"').toString().trim()
  const commitMessage = execSync('git log -1 --format="%s"').toString().trim()
  const commitDate = execSync('git log -1 --format="%ci"').toString().trim()

  const versionInfo = {
    buildDate: new Date().toISOString(),
    commit: `${commitHash} - ${commitMessage}`,
    commitDate: commitDate,
    version: '1.0.0'
  }

  const content = `// Auto-generated version info
// Generated at build time - DO NOT EDIT MANUALLY

export const VERSION_INFO = ${JSON.stringify(versionInfo, null, 2)}
`

  const versionPath = path.join(__dirname, '..', 'src', 'version.js')
  fs.writeFileSync(versionPath, content)

  console.log('✅ Version info generated successfully')
  console.log(`   Commit: ${versionInfo.commit}`)
  console.log(`   Build Date: ${versionInfo.buildDate}`)
} catch (error) {
  console.error('❌ Error generating version info:', error.message)
  console.log('   Using default version info')

  // Fallback version info if git is not available
  const fallbackContent = `// Auto-generated version info
export const VERSION_INFO = {
  buildDate: "${new Date().toISOString()}",
  commit: "Unknown - Git not available",
  commitDate: "Unknown",
  version: "1.0.0"
}
`
  const versionPath = path.join(__dirname, '..', 'src', 'version.js')
  fs.writeFileSync(versionPath, fallbackContent)
}
