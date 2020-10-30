	SELECT * FROM [NhanesData].[dbo].[OHXPER]
	 full outer join dbo.Cardio
	    ON Cardio.SEQN = OHXPER.SEQN

	 full outer join dbo.SMQ
        ON SMQ.SEQN = OHXPER.SEQN
	 full outer join dbo.SMQFAM
        ON SMQFAM.SEQN = OHXPER.SEQN
	 full outer join dbo.SMQRTU
        ON SMQRTU.SEQN = OHXPER.SEQN
	 full outer join dbo.SMQSHS
        ON SMQSHS.SEQN = OHXPER.SEQN

		-- other vars
		 full outer join dbo.Apolio
        ON apolio.SEQN = OHXPER.SEQN
		 full outer join dbo.BioPro
        ON BioPro.SEQN = OHXPER.SEQN
		 full outer join dbo.bp
        ON BP.SEQN = OHXPER.SEQN
		 full outer join dbo.bp_chol
        ON BP_chol.SEQN = OHXPER.SEQN
		 full outer join dbo.cholhdl
        ON cholhdl.SEQN = OHXPER.SEQN
		 full outer join dbo.cholldl
        ON CholLDL.SEQN = OHXPER.SEQN
		 full outer join dbo.compbc
        ON compbc.SEQN = OHXPER.SEQN
		 full outer join dbo.CotiHydro
        ON CotiHydro.SEQN = OHXPER.SEQN
		 full outer join dbo.CurrH        
		ON CurrH.SEQN = OHXPER.SEQN
		 full outer join dbo.demo
		ON demo.SEQN = OHXPER.SEQN
		 full outer join dbo.dietbh
		ON dietbh.SEQN = OHXPER.SEQN
		 full outer join dbo.drug
		ON drug.SEQN = OHXPER.SEQN

		 full outer join dbo.Ferritin
		ON Ferritin.SEQN = OHXPER.SEQN
		 full outer join dbo.glycoh
		ON glycoh.SEQN = OHXPER.SEQN
		 full outer join dbo.HUAC
		ON HUAC.SEQN = OHXPER.SEQN
		 full outer join dbo.medicon
		ON MediCon.SEQN = OHXPER.SEQN
		 full outer join dbo.OHXDEN
		ON ohxden.SEQN = OHXPER.SEQN
		 full outer join dbo.OHXREF
		ON ohxref.SEQN = OHXPER.SEQN
		 full outer join dbo.Oral
		ON Oral.SEQN = OHXPER.SEQN
		 full outer join dbo.OralGluTT
		ON OralGluTT.SEQN = OHXPER.SEQN
		 full outer join dbo.plasfasglu
		ON plasfasglu.SEQN = OHXPER.SEQN
		 full outer join dbo.tchol
		ON TCHOL.SEQN = OHXPER.SEQN
		 full outer join dbo.weight
		ON weight.SEQN = OHXPER.SEQN
		where OHXPER.SEQN is not null

