const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const userController = require('../controllers/userController');

router.post('/consent', authMiddleware, userController.saveConsent);
router.post('/earnings-connection', authMiddleware, userController.connectEarnings);
router.post('/bank-link', authMiddleware, userController.linkBank);
router.get('/banks', authMiddleware, userController.getBanks);
router.delete('/banks/:id', authMiddleware, userController.unlinkBank);
router.post('/suggest-platform', authMiddleware, userController.suggestPlatform);
router.put('/profile', authMiddleware, userController.updateProfile);
router.get('/profile', authMiddleware, userController.getProfile);
router.post('/request-update-otp', authMiddleware, userController.requestUpdateOtp);
router.post('/verify-update-otp', authMiddleware, userController.verifyUpdateOtp);

module.exports = router;