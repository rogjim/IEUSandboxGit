global  class SchedulableInscritosValidados implements Schedulable{
	global void execute(SchedulableContext ctx) {
		Batch_InscritosGrupos batchInscritos = new Batch_InscritosGrupos();
		database.executebatch(batchInscritos,100);
		
		Batch_ValidadosGrupos batchValidados = new Batch_ValidadosGrupos();
		database.executebatch(batchValidados,100);
		
	}
}