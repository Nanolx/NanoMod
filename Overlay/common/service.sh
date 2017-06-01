#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# Make sure init scripts find Busybox
PATH=${PATH}:/dev/busybox

# Create private Log directory
LOGDIR=${MODDIR}/.logs

[[ ! -d ${LOGDIR} ]] && mkdir ${LOGDIR}

# logrotate
for file in ${LOGDIR}/*.log; do
	mv ${file} ${file}.old
done

# This script will be executed in late_start service mode
# More info in the main Magisk thread
${MODDIR}/system/etc/init.d/fstrim | tee -a ${LOGDIR}/fstrim.log
${MODDIR}/system/etc/init.d/logscleaner | tee -a ${LOGDIR}/logscleaner.log
${MODDIR}/system/etc/init.d/sqlite | tee -a ${LOGDIR}/sqlite.log
${MODDIR}/system/etc/init.d/external_sd | tee -a ${LOGDIR}/external_sd.log
