-- without perio data - double the count, so create perio data

SELECT * FROM [NhanesData].[dbo].[huac]
	INNER JOIN dbo.Diabetes
        ON Diabetes.SEQN = huac.SEQN

	INNER JOIN dbo.SMQ
        ON SMQ.SEQN = huac.SEQN
	INNER JOIN dbo.SMQFAM
        ON SMQFAM.SEQN = huac.SEQN
	INNER JOIN dbo.SMQRTU
        ON SMQRTU.SEQN = huac.SEQN
	INNER JOIN dbo.SMQSHS
        ON SMQSHS.SEQN = huac.SEQN
		INNER JOIN dbo.cardio
        ON cardio.SEQN = huac.SEQN
-- other vars
		INNER JOIN dbo.Apolio
        ON apolio.SEQN = huac.SEQN
		INNER JOIN dbo.BioPro
        ON BioPro.SEQN = huac.SEQN
		INNER JOIN dbo.bp
        ON BP.SEQN = huac.SEQN
		INNER JOIN dbo.bp_chol
        ON BP_chol.SEQN = huac.SEQN
		INNER JOIN dbo.cholhdl
        ON cholhdl.SEQN = huac.SEQN
		INNER JOIN dbo.cholldl
        ON CholLDL.SEQN = huac.SEQN
		INNER JOIN dbo.compbc
        ON compbc.SEQN = huac.SEQN
		INNER JOIN dbo.CotiHydro
        ON CotiHydro.SEQN = huac.SEQN
		INNER JOIN dbo.CurrH        
		ON CurrH.SEQN = huac.SEQN
		INNER JOIN dbo.demo
		ON demo.SEQN = huac.SEQN
		INNER JOIN dbo.dietbh
		ON dietbh.SEQN = huac.SEQN
		INNER JOIN dbo.drug
		ON drug.SEQN = huac.SEQN

--		INNER JOIN dbo.Ferritin
--		ON Ferritin.SEQN = huac.SEQN
		INNER JOIN dbo.glycoh
		ON glycoh.SEQN = huac.SEQN
		
		INNER JOIN dbo.medicon
		ON MediCon.SEQN = huac.SEQN
		INNER JOIN dbo.OHXDEN
		ON ohxden.SEQN = huac.SEQN
		INNER JOIN dbo.OHXREF
		ON ohxref.SEQN = huac.SEQN
		INNER JOIN dbo.Oral
		ON Oral.SEQN = huac.SEQN
		INNER JOIN dbo.OralGluTT
		ON OralGluTT.SEQN = huac.SEQN
		INNER JOIN dbo.plasfasglu
		ON plasfasglu.SEQN = huac.SEQN
		INNER JOIN dbo.tchol
		ON TCHOL.SEQN = huac.SEQN
		INNER JOIN dbo.weight
		ON weight.SEQN = huac.SEQN