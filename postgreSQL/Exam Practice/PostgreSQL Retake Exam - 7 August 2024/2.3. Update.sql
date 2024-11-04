UPDATE productions_info 
SET duration = duration + 15 WHERE synopsis IS NULL AND id < 15;

UPDATE productions_info 
SET duration = duration + 20 WHERE synopsis IS NULL AND id >= 20;