SELECT * FROM [NhanesData].[dbo].[OHXPER]
	INNER JOIN dbo.Cardio
        ON cardio.SEQN = OHXPER.SEQN
	INNER JOIN dbo.Diabetes
        ON Diabetes.SEQN = OHXPER.SEQN

	INNER JOIN dbo.SMQ
        ON SMQ.SEQN = OHXPER.SEQN
	INNER JOIN dbo.SMQFAM
        ON SMQFAM.SEQN = OHXPER.SEQN
	INNER JOIN dbo.SMQRTU
        ON SMQRTU.SEQN = OHXPER.SEQN
	INNER JOIN dbo.SMQSHS
        ON SMQSHS.SEQN = OHXPER.SEQN

-- other vars
		INNER JOIN dbo.Apolio
        ON apolio.SEQN = OHXPER.SEQN
		INNER JOIN dbo.BioPro
        ON BioPro.SEQN = OHXPER.SEQN
		INNER JOIN dbo.bp
        ON BP.SEQN = OHXPER.SEQN
		INNER JOIN dbo.bp_chol
        ON BP_chol.SEQN = OHXPER.SEQN
		INNER JOIN dbo.cholhdl
        ON cholhdl.SEQN = OHXPER.SEQN
		INNER JOIN dbo.cholldl
        ON CholLDL.SEQN = OHXPER.SEQN
		INNER JOIN dbo.compbc
        ON compbc.SEQN = OHXPER.SEQN
		INNER JOIN dbo.CotiHydro
        ON CotiHydro.SEQN = OHXPER.SEQN
		INNER JOIN dbo.CurrH        
		ON CurrH.SEQN = OHXPER.SEQN
		INNER JOIN dbo.demo
		ON demo.SEQN = OHXPER.SEQN
		INNER JOIN dbo.dietbh
		ON dietbh.SEQN = OHXPER.SEQN
		INNER JOIN dbo.drug
		ON drug.SEQN = OHXPER.SEQN

--		INNER JOIN dbo.Ferritin
--		ON Ferritin.SEQN = OHXPER.SEQN
		INNER JOIN dbo.glycoh
		ON glycoh.SEQN = OHXPER.SEQN
		INNER JOIN dbo.HUAC
		ON HUAC.SEQN = OHXPER.SEQN
		INNER JOIN dbo.medicon
		ON MediCon.SEQN = OHXPER.SEQN
		INNER JOIN dbo.OHXDEN
		ON ohxden.SEQN = OHXPER.SEQN
		INNER JOIN dbo.OHXREF
		ON ohxref.SEQN = OHXPER.SEQN
		INNER JOIN dbo.Oral
		ON Oral.SEQN = OHXPER.SEQN
		INNER JOIN dbo.OralGluTT
		ON OralGluTT.SEQN = OHXPER.SEQN
		INNER JOIN dbo.plasfasglu
		ON plasfasglu.SEQN = OHXPER.SEQN
		INNER JOIN dbo.tchol
		ON TCHOL.SEQN = OHXPER.SEQN
		INNER JOIN dbo.weight
		ON weight.SEQN = OHXPER.SEQN





		