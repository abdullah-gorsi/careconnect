@echo off
echo Deploying Firestore Rules...
npx -y firebase-tools deploy --only firestore:rules
pause
