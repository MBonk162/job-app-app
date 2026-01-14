# Manual Keystore Creation (If Scripts Fail)

If the automated scripts don't work, you can create the keystore manually.

## Step 1: Find keytool

keytool is part of the Java JDK. It's usually located at:

**If you have Android Studio:**
```
C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe
```

**If you have Java JDK installed:**
```
C:\Program Files\Java\jdk-XX\bin\keytool.exe
```

## Step 2: Open PowerShell or Command Prompt

1. Press **Windows + X**
2. Select **Windows PowerShell** or **Command Prompt**
3. Navigate to the android directory:
   ```
   cd C:\Users\mbonkowski\job_app_app\mobile\android
   ```

## Step 3: Run keytool Command

### Option A: If keytool is in your PATH

```bash
keytool -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### Option B: Using full path to Android Studio's keytool

```bash
"C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

## Step 4: Answer the Prompts

You'll be asked for:

1. **Enter keystore password:** Create a strong password (e.g., `MyApp2024!Secure`)
   - **WRITE THIS DOWN!**
2. **Re-enter new password:** Same password again
3. **What is your first and last name?** Your name (e.g., `Mitch Bonkowski`)
4. **What is the name of your organizational unit?** Can be anything (e.g., `Personal`)
5. **What is the name of your organization?** Can be anything (e.g., `Personal`)
6. **What is the name of your City or Locality?** Your city (e.g., `Chicago`)
7. **What is the name of your State or Province?** Your state (e.g., `Illinois`)
8. **What is the two-letter country code for this unit?** Two letters (e.g., `US`)
9. **Is CN=... correct?** Type `yes`
10. **Enter key password for <upload>:** Press Enter to use same password

## Step 5: Verify File Created

Check that this file exists:
```
C:\Users\mbonkowski\job_app_app\mobile\android\app\upload-keystore.jks
```

In PowerShell:
```powershell
Test-Path app/upload-keystore.jks
```

Should return: `True`

Or in Command Prompt:
```cmd
dir app\upload-keystore.jks
```

Should show the file details.

## Step 6: Create key.properties

Create a file at `C:\Users\mbonkowski\job_app_app\mobile\android\key.properties`:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=app/upload-keystore.jks
```

Replace `YOUR_KEYSTORE_PASSWORD` and `YOUR_KEY_PASSWORD` with the passwords you created in Step 4.

## Troubleshooting

### "keytool is not recognized"

keytool is not in your PATH. Use Option B with the full path to keytool.

### "The system cannot find the path specified"

Make sure you're in the `mobile/android` directory when running the command.

Check with:
```
pwd           # PowerShell
cd            # Command Prompt
```

Should show: `C:\Users\mbonkowski\job_app_app\mobile\android`

### "Access denied" or "Permission denied"

Run PowerShell or Command Prompt as Administrator:
1. Right-click on PowerShell/Command Prompt
2. Select "Run as Administrator"

### File created but in wrong location

If the file was created somewhere else, just move it to:
```
C:\Users\mbonkowski\job_app_app\mobile\android\app\upload-keystore.jks
```

## Example Complete Session

```
C:\Users\mbonkowski\job_app_app\mobile\android> keytool -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

Enter keystore password: ********
Re-enter new password: ********
What is your first and last name?
  [Unknown]:  Mitch Bonkowski
What is the name of your organizational unit?
  [Unknown]:  Personal
What is the name of your organization?
  [Unknown]:  Personal
What is the name of your City or Locality?
  [Unknown]:  Chicago
What is the name of your State or Province?
  [Unknown]:  Illinois
What is the two-letter country code for this unit?
  [Unknown]:  US
Is CN=Mitch Bonkowski, OU=Personal, O=Personal, L=Chicago, ST=Illinois, C=US correct?
  [no]:  yes

Enter key password for <upload>
        (RETURN if same as keystore password): [Press Enter]

[Storing app/upload-keystore.jks]
```

Success! The file is now at `app/upload-keystore.jks`.
