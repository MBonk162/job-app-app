import nodemailer from 'nodemailer'
import dotenv from 'dotenv'

dotenv.config()

// Create email transporter
const createTransporter = () => {
  // Use Gmail or any other SMTP service
  return nodemailer.createTransport({
    service: process.env.EMAIL_SERVICE || 'gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASSWORD
    }
  })
}

// Send job application to Trello board via email
export const sendJobToTrello = async (applicationData) => {
  // Skip if email credentials not configured
  if (!process.env.EMAIL_USER || !process.env.EMAIL_PASSWORD) {
    console.log('⏭️  Skipping Trello email - EMAIL credentials not configured')
    return { success: false, error: 'Email credentials not configured' }
  }

  try {
    const transporter = createTransporter()

    // Format the application data as JSON for the email body
    const jsonData = JSON.stringify(applicationData, null, 2)

    // Create email content
    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: process.env.TRELLO_EMAIL || 'mitchellbonkowski+3rzoceeitkcasphu4slr@app.trello.com',
      subject: `New Job Application: ${applicationData.company} - ${applicationData.role_title}`,
      text: `New job application created:\n\n${jsonData}`,
      html: `
        <h2>New Job Application Created</h2>
        <h3>${applicationData.company} - ${applicationData.role_title}</h3>
        <pre>${jsonData}</pre>
      `
    }

    const info = await transporter.sendMail(mailOptions)
    console.log('Email sent to Trello board:', info.messageId)
    return { success: true, messageId: info.messageId }
  } catch (error) {
    console.error('Error sending email to Trello:', error.message)
    // Don't throw error - we don't want to fail the application creation if email fails
    return { success: false, error: error.message }
  }
}
