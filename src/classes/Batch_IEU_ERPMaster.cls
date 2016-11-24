global class Batch_IEU_ERPMaster implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    String query;
    String method;
    String request = '';
    
    global Batch_IEU_ERPMaster(String mtd) {
        method = mtd;
        if(method != null && String.isNotEmpty(method)) {
            if(method == 'addCandidatoInfo') {
                query = 'SELECT EnviadoERP__c, ModificadoERP__c, Account.Ciudad__c, Folio__c ,Account.Profesion__r.IdProfesion__c, Account.Pais__r.IdUbicacion__c, Periodo__r.IdPeriodo__c, Account.FirstName,';
                query = query +' Account.LastName, Account.ApeMaterno__c, Account.Calle__c, Account.NumeroExterior__c, Account.NumeroInterior__c,Account.Sexo__c, ';
                query = query + ' Account.Colonia__c, Account.Estado__r.IdUbicacion__c, Account.CP__c, Account.Phone, Account.PersonHomePhone, Account.PersonMobilePhone, Account.PersonEmail, Plantel__r.IdInterno__c,';
                query = query + 'Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Grupo__r.IdGrupo__c, Pago__c, Owner.IDInterno__c, ';
                query = query + ' Account.FechaNacimiento__c,  Account.EstadoCivil__c, Account.CreatedDate, (SELECT Id, Name, FechaPago__c FROM Fichas_de_pago__r WHERE FechaPago__c!=null ORDER BY FechaPago__c DESC), ' ;
                query = query + ' IdPeriodoPagado__c,IdPlantelPagado__c, IdNivelPagado__c ,IdProgramaPagado__c,IdGrupoPagado__c,EnviadoERPFecha__c ';
                query = query + ' FROM Opportunity ';
                query = query +'  WHERE  (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) ';
                //query = query +'  WHERE  EnviadoERP__c = false';
                query = query + ' AND Periodo__r.IdPeriodo__c!=null AND Account.FirstName!=null AND Account.LastName!=null ';
                query = query + ' AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null';
                query = query +'  AND Grupo__r.IdGrupo__c!=null AND Owner.IDInterno__c!=null AND Id IN(SELECT Oportunidad__c FROM FichaPago__c WHERE FechaPago__c!=null AND MontoPagado__c!=null)';
                query = query +'  AND Pago__c =  true';
            } else if(method == 'addPagosInscripcionInfo') {
                query = 'SELECT ' + Utils.getStrCampos(FichaPago__c.SObjectType) + ',Plantel__r.IdInterno__c, Oportunidad__r.Pago__c,Oportunidad__r.Nivel__r.Name';
                query = query + ' FROM FichaPago__c ';
                query = query + ' WHERE FechaPago__c != null AND MontoPagado__c != null' ;
                query = query +' AND EnviadoERP__c = false AND Oportunidad__r.Pago__c = true AND FechaPago__c > 2016-10-09 ORDER BY FechaPago__c ASC, CreatedDate ASC';
               // query = query + ' AND Id != \'a0T15000008Qtpl\'';
            }else if(method == 'addGrupoInfo') {                
                query = ' SELECT  UsuarioApertura__r.idInterno__c,Name,Nomenclatura__c, OfertaEducativa__r.RvoeVigente__r.idModalidadProg__c,Sede__r.IdInterno__c,IdTurno__c, EnviadoERP__c, ModificadoERP__c, ' ;
                query = query + ' FechaInicioClases__c, Activo__c, AperturaOperativo__c, UsuarioApertura__r.Name, FechaApertura__c, FechaRegistro__c, IdGrupo__c, Grupo__c, OfertaEducativa__r.Plantel__r.IdInterno__c, ' ;
                query = query + ' OfertaEducativa__r.Periodo__r.IdPeriodo__c, OfertaEducativa__r.Programa__r.IdInterno__c, OfertaEducativa__r.Nivel__r.IdInternoNivel__c, OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c, ' ;
                query = query +'  Sede__r.ClavePlantelDepende__c, Sede__r.Name, Periodicidad__r.IdInternoPeriodicidad__c,Estatus__c,EnviadoERPFecha__c ' ;
                query = query + ' FROM Grupo__c WHERE';
                query = query +'  (EnviadoERP__c = false OR ModificadoERP__c = true)';
                //query = query +'  EnviadoERP__c=false ';
                query = query + ' AND IdGrupo__c!=null AND OfertaEducativa__r.Plantel__r.IdInterno__c!=null';
                query = query + ' AND OfertaEducativa__r.Programa__r.IdInterno__c!=null  AND OfertaEducativa__r.Nivel__r.IdInternoNivel__c!=null  AND IdTurno__c!=null';
                query = query +  ' AND OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c!=null  AND Periodicidad__r.IdInternoPeriodicidad__c!=null';
                query = query + '  AND FechaRegistro__c!=null  AND FechaInicioClases__c!=null    AND Activo__c!=NULL  and OfertaEducativa__r.RvoeVigente__r.idModalidadProg__c != null  ';
                query = query + ' AND OfertaEducativa__r.Periodo__r.IdPeriodo__c != null';
               // query = query + ' AND OfertaEducativa__r.Periodo__r.IdPeriodo__c = 26';
            }else if(method == 'addPagosGrupoInfo') {
                query = 'SELECT IdGrupo__c,EnviadoERPGrupoPago__c, EnviadoERP__c,ModificadoERPGrupoPago__c, ModificadoERP__c, OfertaEducativa__c, OfertaEducativa__r.NumeroInscripciones__c, OfertaEducativa__r.NumeroColegiaturas__c ';
                query = query +  'FROM Grupo__c ';
                query = query +  'WHERE ';
                query = query +  ' (EnviadoERPGrupoPago__c=false OR ModificadoERPGrupoPago__c=true) AND';
                query = query + ' IdGrupo__c!=null AND OfertaEducativa__r.Plantel__r.IdInterno__c!=null';
                query = query + ' AND OfertaEducativa__r.Programa__r.IdInterno__c!=null  AND OfertaEducativa__r.Nivel__r.IdInternoNivel__c!=null  AND IdTurno__c!=null';
                query = query +  ' AND OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c!=null  AND Periodicidad__r.IdInternoPeriodicidad__c!=null';
                query = query + '  AND FechaRegistro__c!=null  AND FechaInicioClases__c!=null AND OfertaEducativa__r.RvoeVigente__r.idModalidadProg__c != null  ';
                query = query + ' AND OfertaEducativa__r.Periodo__r.IdPeriodo__c != null';
                //query = query + ' AND OfertaEducativa__r.Periodo__r.IdPeriodo__c = 26';
            } else if(method == 'addBecasInfo') {
                query = 'SELECT   Account.Name,Folio__c,Periodo__r.IdPeriodo__c,Plantel__r.IdInterno__c,Nivel__r.IdInternoNivel__c,Beca__r.IdInterno__c,Beca__r.IdInternoConvenio__c,Beca__r.FechaAutorizacion__c,'; 
                query =  query + 'EnviadoERP__c,ModificadoERP__c, EnviadoBecaERP__c ,Ownerid,Programa__r.IdInterno__c,Beca__r.A__c,Beca__r.B__c,Beca__r.C__c, Beca__r.D__c,Beca__r.E__c,Beca__r.F__c, Beca__r.G__c, ';
                query =  query + ' Beca__r.CreatedDate,Beca__r.CreatedBy.Name,Beca__r.IdTipoBeca__c,Beca__r.RecordType.Name, LetraBeca__c,LetraBecaValor__c,';
                query =  query + ' FechaOtorgaBeca__c, UsuarioOtorgaBeca__c,CreatedDate, ';
                query =  query + ' (SELECT Id, Name, FechaPago__c FROM Fichas_de_pago__r  WHERE FechaPago__c!=null ORDER BY FechaPago__c DESC) ,Beca__c, PorcentajeBeca__c, ValorLetra__c, TipoBeca__c , Owner.idInterno__c';
                query =  query + ' FROM Opportunity ';
                query =  query + ' WHERE   Account.Name!=null AND Folio__c!=null AND Periodo__r.IdPeriodo__c!=null AND Plantel__r.IdInterno__c!=null';
                query =  query + ' AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Beca__r.CreatedDate!=null AND Beca__r.CreatedBy.Name!=null';
                query =  query  +' AND Id IN(SELECT Oportunidad__c FROM FichaPago__c WHERE FechaPago__c!=null)';
                query =  query + ' AND (EnviadoBecaERP__c = false OR ModificadoBecaERP__c = true) ';
                query = query + ' AND Beca__c!=null AND Pago__c=true ';
                query =  query + ' AND  Owner.idInterno__c  !=null';
            }   else {
                System.debug('Method ' + method + ' is not defined.');
            }
            System.debug('query a ejcutar: ' + query);
        } else {
            System.debug('Method is required.');
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> sobjects) {
        
        IEU_ERPMasterCliente cliente = new IEU_ERPMasterCliente(120000);
        String user = Negocio__c.getOrgDefaults().UsuarioERPWS__c;
        String pwd = Negocio__c.getOrgDefaults().PasswordERPWS__c;
        String response = '';
        
        if(method != null && String.isNotEmpty(method)) {
            Boolean GrupoPago= false;
            Boolean GrupoInfo= false;
            
            System.debug('executa método:' + method);
            if(method == 'addCandidatoInfo') {
                IEU_ERPMaster.ArrayOfCandidatoInfo ls = addCandidatoInfo(sobjects);
                response = cliente.addCandidato(user, pwd, ls);
                for(IEU_ERPMaster.CandidatoInfo ci : ls.CandidatoInfo) {
                    
                    if(request.length() > 0) {
                        request+=',';
                    }
                    request+='{folio:'+ci.folio+',';
                    request+='idprofesion:'+ci.idprofesion+',';
                    request+='idpais:'+ci.idpais+',';
                    request+='periodo:'+ci.periodo+',';
                    request+='idEstado:'+ci.idEstado+',';
                    request+='idPlantel:'+ci.idPlantel+',';
                    request+='Prog1Nivel:'+ci.Prog1Nivel+',';
                    request+='Prog1Clave:'+ci.Prog1Clave+',';
                    request+='idGrupo:'+ci.idGrupo+',';
                    request+='pagado:'+ci.pagado+',';
                    request+='periodoPago:'+ci.periodoPago+',';
                    request+='idPlantelPago:'+ci.idPlantelPago+',';
                    request+='Prog1NivelPago:'+ci.Prog1NivelPago+',';
                    request+='Prog1ClavePago:'+ci.Prog1ClavePago+',';
                    request+='idGrupoPago:'+ci.idGrupoPago+',';
                    request+='actualizar:'+ci.actualizar+',';
                    request+='idedocivil:'+ci.idedocivil+',';
                    
                    request+='nombre:\''+ci.nombre+'\',';
                    request+='nombre:\''+ci.nombre+'\',';
                    request+='aMaterno:\''+ci.aMaterno+'\',';
                    request+='domicilio:\''+ci.domicilio+'\',';
                    request+='colonia:\''+ci.colonia+'\',';
                    request+='ciudad:\''+ci.ciudad+'\',';
                    request+='cp:\''+ci.cp+'\',';
                    request+='telCasa:\''+ci.telCasa+'\',';
                    request+='telOficina:\''+ci.telOficina+'\',';
                    request+='celular:\''+ci.celular+'\',';
                    request+='mail:\''+ci.mail+'\',';
                    request+='usuario:\''+ci.usuario+'\',';
                    request+='fechaPago:\''+ci.fechaPago+'\',';
                    request+='fechaNac:\''+ci.fechaNac+'\',';
                    request+='fRegistro:\''+ci.fRegistro+'\'}';
                }
            } else if(method == 'addGrupoInfo') {
                IEU_ERPMaster.ArrayOfGrupoInfo ls = addGrupoInfo(sobjects);
                response = cliente.addGrupo(user, pwd, ls);
                for(IEU_ERPMaster.GrupoInfo gi : ls.GrupoInfo) {
                    if(request.length() > 0) {
                        request+=',';
                    }
                    request+='{idGrupo:'+gi.idGrupo+',';
                    request+='idPlantel:'+gi.idPlantel+',';
                    request+='periodo:'+gi.periodo+',';
                    request+='grupo:\''+gi.grupo+'\',';
                    request+='programa:'+gi.programa+',';
                    request+='nivel:'+gi.nivel+',';
                    request+='idTurno:'+gi.idTurno+',';
                    request+='modalidad:\''+gi.modalidad+'\',';
                    request+='periodicidad:'+gi.periodicidad+',';
                    request+='fechaRegistro:\''+gi.fechaRegistro+'\',';
                    request+='fechaInicio:\''+gi.fechaInicio+'\',';
                    request+='activo:'+gi.activo+',';
                    request+='aperturaOperativo:'+gi.aperturaOperativo+',';
                    request+='usuarioApertura:\''+gi.usuarioApertura+'\',';
                    request+='fAperturaO:\''+gi.fAperturaO+'\',';
                    request+='sede:'+gi.sede+',';
                    request+='sede1:\''+gi.sede1+'\',';
                    request+='actualizar:'+gi.actualizar+'}';
                }
            } else if(method == 'addBecasInfo') {
                IEU_ERPMaster.ArrayOfBecasInfo ls = addBecasInfo(sobjects);
                response = cliente.addBeca(user, pwd, ls);
                for(IEU_ERPMaster.BecasInfo bi: ls.BecasInfo) {
                    if(request.length() > 0) {
                        request+=',';
                    }
                    request+='{usuario:\''+bi.usuario+'\',';
                    request+='folio:'+bi.folio+',';
                    request+='idperiodo:'+bi.idperiodo+',';
                    request+='idplantel:'+bi.idplantel+',';
                    request+='idnivel:'+bi.idnivel+',';
                    request+='idprograma:'+bi.idprograma+',';
                    request+='idbeca:'+bi.idbeca+',';
                    request+='porcentaje:'+bi.porcentaje+',';
                    request+='valor:'+bi.valor+',';
                    request+='fecharegistro:\''+bi.fecharegistro+'\',';
                    request+='usuarioRegistra:\''+bi.usuarioRegistra+'\',';
                    request+='esquema:'+bi.esquema+',';
                    request+='usuarioAutoriza:\''+bi.usuarioAutoriza +'\',';
                    request+='fechaAutorizacion:\''+bi.fechaAutorizacion+'\',';
                    request+='actualizar:'+bi.actualizar+'}';
                }
            } else if(method == 'addPagosGrupoInfo') {
                GrupoPago = true;
                IEU_ERPMaster.ArrayOfPagosGrupoInfo ls = addPagosGrupoInfo(sobjects);
                response = cliente.addPagosGrupo(user, pwd, ls);
                for(IEU_ERPMaster.PagosGrupoInfo pgi: ls.PagosGrupoInfo) {
                    if(request.length() > 0) {
                        request+=',';
                    }
                    request+='{usuario:'+pgi.idGrupo+',';
                    request+='{usuario:'+pgi.concepto+',';
                    request+='{usuario:'+pgi.cantidad+',';
                    request+='{usuario:'+pgi.costo+',';
                    request+='actualizar:'+pgi.actualizar+'}';
                }
            } else if(method == 'addPagosInscripcionInfo') {
                IEU_ERPMaster.ArrayOfPagosInscripcionInfo ls = addPagosInscripcionInfo(sobjects);
                response = cliente.addPagosInscripcion(user, pwd, ls);
                for(IEU_ERPMaster.PagosInscripcionInfo pii : ls.PagosInscripcionInfo) {
                    if(request.length() > 0) {
                        request+=',';
                    }
                    request+='{folio:'+pii.folio+',';
                    request+='periodo:'+pii.periodo+',';
                    request+='idPlantel:'+pii.idPlantel+',';
                    request+='concepto:'+pii.concepto+',';
                    request+='idFormaPago:'+pii.idFormaPago+',';
                    request+='idBanco:'+pii.idBanco+',';
                    request+='cantidad:'+pii.cantidad+',';
                    request+='numAutorizacion:\''+pii.numAutorizacion +'\',';
                    request+='fechaPago:\''+pii.fechaPago +'\',';
                    request+='tipoTarjeta:'+pii.tipoTarjeta+',';
                    request+='actualizar:'+pii.actualizar+'}';
                }
            } else {
                System.debug('Method ' + method + ' is not defined.');
            }
            if(String.isNotEmpty(response) && response == 'Estatus ok: Correcto') {
                for(sObject sobj : sobjects) { 
                    //Sobre Opportunity
                    if (method == 'addCandidatoInfo' ){
                        sobj.put('EnviadoERP__c', true);
                        sobj.put('EnviadoERPFecha__c', datetime.now());  
                        sobj.put('ModificadoERP__c', false); //Se modifica en TriggerOportunidadHandler
                        
                    }
                    //Sobre Ficha__c
                    if (method == 'addPagosInscripcionInfo'){
                        sobj.put('EnviadoERP__c', true);
                        sobj.put('EnviadoERPFecha__c', datetime.now());  
                    }
                    //Sobre Grupo__c
                    if (method == 'addGrupoInfo' ){
                        sobj.put('EnviadoERP__c', true);
                        sobj.put('EnviadoERPFecha__c', datetime.now());  
                        sobj.put('ModificadoERP__c', false); //Se modifica en TriggerGrupoHandler
                                               
                    }
                    //Sobre Grupo__c
                    if (method == 'addPagosGrupoInfo'){
                        sobj.put('EnviadoERPGrupoPago__c', true);
                        sobj.put('EnviadoERPGrupoPagoFecha__c', datetime.now());  
                        sobj.put('ModificadoERPGrupoPago__c', false); //Se modifica en TriggerOfertaConceptoPago
                    }
                    //Sobre Opportunity
                     if( method == 'addBecasInfo'){
                        sobj.put('EnviadoBecaERP__c', true);
                        sobj.put('EnviadoBecaERPFecha__c', datetime.now());  
                        sobj.put('ModificadoBecaERP__c', false);//Se modifica en TriggerOportunidadHandler
                    } 
                    
                }
                update sobjects;
                //UtilsLog.createLogOK(method, response, String.valueOf(BC.getJobId()), sobjects.size());
                UtilsLog.createLogOK(method, 'body: [' +  request+']}',response, String.valueOf(BC.getJobId()), sobjects.size());
            } else if(String.isNotEmpty(response)) {
                UtilsLog.createLogError(method,  '{user: \'' + user + '\', pwd: \'' + pwd + '\', body: [' +  request+']}', response, String.valueOf(BC.getJobId()), sobjects.size());
            }
            
        } else {
            System.debug('Method is required.');
        }
    }
    
    public static boolean hasSObjectField(String fieldName, SObject so){
        return so.getSobjectType().getDescribe().fields.getMap().keySet().contains(fieldName);
    }
    
    global void finish(Database.BatchableContext BC) {
        AsyncApexJob a = [SELECT Id, CreatedDate, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        List<LogIntegracion__c> logIntegracion = [SELECT Id, Estatus__c, RespuestaWS__c, NumeroRegistros__c FROM LogIntegracion__c WHERE ApexJobId__c=:BC.getJobId()];
        String response = '';
        Integer i = 1;
        for(LogIntegracion__c li : logIntegracion) {
            response += '\t-Envío ' + i++ + ', registros enviados: ' + li.NumeroRegistros__c + ', respuesta: '+li.RespuestaWS__c +'\n';
        }
        if(response.length() > 0) {
            response = '\n\nRespuestas del servicio web: \n' + response;
        } else {
            response = 'No hay información para ser enviada.';
        }
        
        // Send an email to the Apex job's submitter 
        //   notifying of job completion. 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //String[] toAddresses = new String[] {a.CreatedBy.Email};
        //String[] toAddresses = new String[] {'calvarez@ctconsulting.com.mx'};
        List<String> toAddresses = Negocio__c.getOrgDefaults().CorreoBatchERP__c != null ? String.valueOf(Negocio__c.getOrgDefaults().CorreoBatchERP__c).split(',') : new String[] {'calvarez@ctconsulting.com.mx'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Resúmen de ejecución de método: ' + method);
        mail.setPlainTextBody('Lotes ejecutados: ' + a.TotalJobItems +', errores: '+ a.NumberOfErrors +',' + response +'\n\n Hora de inicio:     ' + a.CreatedDate.format('dd-MM-YYYY HH:mm ss') +'\n Hora de término: ' + DateTime.now().format('dd-MM-YYYY HH:mm ss'));
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
       
    }
    
    
    
    //Antes addCandidatoInfo_OP
    public IEU_ERPMaster.ArrayOfCandidatoInfo addCandidatoInfo(List<sObject> sobjects) {
        IEU_ERPMaster.ArrayOfCandidatoInfo ls = new IEU_ERPMaster.ArrayOfCandidatoInfo();
        ls.CandidatoInfo = new List<IEU_ERPMaster.CandidatoInfo>();
        for(sObject obj: sobjects) {
            Opportunity lead = (Opportunity) obj;
            IEU_ERPMaster.CandidatoInfo  candidatoInfo = new IEU_ERPMaster.CandidatoInfo();
            candidatoInfo.folio = lead.Folio__c != null && lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
            candidatoInfo.idprofesion = lead.Account.Profesion__r.IdProfesion__c != null ? Integer.valueOf(lead.Account.Profesion__r.IdProfesion__c) : 1;
            candidatoInfo.idpais = lead.Account.Pais__r.IdUbicacion__c != null && lead.Account.Pais__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Account.Pais__r.IdUbicacion__c) : 0;
            candidatoInfo.nombre = lead.Account.FirstName != null ? lead.Account.FirstName : '';
            if(candidatoInfo.nombre.length() > 30) {
                candidatoInfo.nombre = candidatoInfo.nombre.substring(0, 29);
            }
            candidatoInfo.aPaterno = lead.Account.LastName != null ? lead.Account.LastName : '';
            if(candidatoInfo.aPaterno.length() > 25) {
                candidatoInfo.aPaterno = candidatoInfo.aPaterno.substring(0, 24);
            }
            candidatoInfo.aMaterno = lead.Account.ApeMaterno__c != null ? lead.Account.ApeMaterno__c : '';
            if(candidatoInfo.aMaterno.length() > 25) {
                candidatoInfo.aMaterno = candidatoInfo.aMaterno.substring(0, 24);
            }
            candidatoInfo.domicilio = (lead.Account.Calle__c  != null ? lead.Account.Calle__c : '') + ' ' + (lead.Account.NumeroExterior__c != null ? lead.Account.NumeroExterior__c : '')+ ' ' + (lead.Account.NumeroInterior__c != null ? lead.Account.NumeroInterior__c : '');
            if(candidatoInfo.domicilio.length() > 55) {
                candidatoInfo.domicilio = candidatoInfo.domicilio.substring(0, 54);
            }
            candidatoInfo.colonia = lead.Account.Colonia__c != null ? lead.Account.Colonia__c : '';
            if(candidatoInfo.colonia.length() > 35) {
                candidatoInfo.colonia = candidatoInfo.colonia.substring(0, 34);
            }
            candidatoInfo.ciudad = lead.Account.Ciudad__c != null ? lead.Account.Ciudad__c : '';
            if(candidatoInfo.ciudad.length() > 35) {
                candidatoInfo.ciudad = candidatoInfo.ciudad.substring(0, 34);
            }
            candidatoInfo.cp = lead.Account.CP__c != null ? String.valueOf(lead.Account.CP__c) : '';
            if(candidatoInfo.cp.length() > 10) {
                candidatoInfo.cp = candidatoInfo.cp.substring(0, 9);
            }
            candidatoInfo.idEstado = lead.Account.Estado__r.IdUbicacion__c != null && lead.Account.Estado__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Account.Estado__r.IdUbicacion__c) : 21;
            candidatoInfo.periodo = Integer.valueOf(lead.Periodo__r.IdPeriodo__c);
            candidatoInfo.telCasa = lead.Account.Phone != null ? lead.Account.Phone : '';
            if(candidatoInfo.telCasa.length() > 10) {
                candidatoInfo.telCasa = candidatoInfo.telCasa.substring(0, 9);
            }
            candidatoInfo.telOficina = lead.Account.PersonHomePhone != null ? lead.Account.PersonHomePhone : '';
            if(candidatoInfo.telOficina.length() > 10) {
                candidatoInfo.telOficina = candidatoInfo.telOficina.substring(0, 9);
            }
            candidatoInfo.celular = lead.Account.PersonMobilePhone != null ? lead.Account.PersonMobilePhone : '';
            if(candidatoInfo.celular.length() > 10) {
                candidatoInfo.celular = candidatoInfo.celular.substring(0, 9);
            }
            candidatoInfo.mail = lead.Account.PersonEmail != null ? lead.Account.PersonEmail : '';
            if(candidatoInfo.mail.length() > 80) {
                candidatoInfo.mail = candidatoInfo.mail.substring(0, 79);
            }
            candidatoInfo.idPlantel = Integer.valueOf(lead.Plantel__r.IdInterno__c);
            
            candidatoInfo.Prog1Nivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
            candidatoInfo.Prog1Clave = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Programa__r.IdInterno__c)) : 0;
            candidatoInfo.idGrupo =  Integer.valueOf(lead.Grupo__r.IdGrupo__c);
            candidatoInfo.pagado = 1; 
            candidatoInfo.usuario = lead.Owner.IDInterno__c != null ? lead.Owner.IDInterno__c : '';
            if(lead.Fichas_de_pago__r != null && lead.Fichas_de_pago__r.size() > 0){
                candidatoInfo.fechaPago = String.valueOf(lead.Fichas_de_pago__r[0].FechaPago__c);
            }
            
            if(lead.Account.FechaNacimiento__c != null ){
                String dt = DateTime.newInstance(lead.Account.FechaNacimiento__c.year(),lead.Account.FechaNacimiento__c.month(),lead.Account.FechaNacimiento__c.day()).format('yyyy-MM-dd');
                candidatoInfo.fechaNac = dt;
            }else{
                candidatoInfo.fechaNac =  '0000-00-00';
            }
            
            candidatoInfo.idsexo = 0;
            if(lead.Account.Sexo__c == 'Masculino') {
                candidatoInfo.idsexo = 1;
            } else if(lead.Account.Sexo__c == 'Femenino') {
                candidatoInfo.idsexo = 2;
            }
            
            candidatoInfo.idedocivil = 1;
            if(lead.Account.EstadoCivil__c == 'Soltero') {
                candidatoInfo.idedocivil = 1;
            } else if(lead.Account.EstadoCivil__c == 'Casado') {
                candidatoInfo.idedocivil = 2;
            } else if(lead.Account.EstadoCivil__c == 'Divorciado') {
                candidatoInfo.idedocivil = 3;
            } else if(lead.Account.EstadoCivil__c == 'Viudo') {
                candidatoInfo.idedocivil = 4;
            }
            if(lead.Account.CreatedDate != null ){
                String dt = DateTime.newInstance(lead.Account.CreatedDate.year(),lead.Account.CreatedDate.month(),lead.Account.CreatedDate.day()).format('yyyy-MM-dd');
                candidatoInfo.fRegistro = dt;
            }else{
                candidatoInfo.fRegistro = datetime.now().format('yyyy-MM-dd');
            }
            
            /////////
            candidatoInfo.periodoPago = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
            candidatoInfo.idPlantelPago = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(lead.Plantel__r.IdInterno__c) : 0;
            candidatoInfo.Prog1NivelPago = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(lead.Nivel__r.IdInternoNivel__c) : 0;
            candidatoInfo.Prog1ClavePago = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
            candidatoInfo.idGrupoPago = lead.Grupo__r.IdGrupo__c != null && String.valueof(lead.Grupo__r.IdGrupo__c).isNumeric() ? Integer.valueOf(lead.Grupo__r.IdGrupo__c) : 0;
            candidatoInfo.actualizar =  lead.ModificadoERP__c ? 1 : 0; //FIJO PARA PRUEBAS DEEBE CAMBIARSE A ModificadoERP__c
            
            /////////
            candidatoInfo.periodoPagado = lead.IdPeriodoPagado__c != null ? Integer.valueOf(lead.IdPeriodoPagado__c) : 0;
            candidatoInfo.plantelPagado = lead.IdPlantelPagado__c != null ? Integer.valueOf(lead.IdPlantelPagado__c) : 0;
            candidatoInfo.nivelPagado = lead.IdNivelPagado__c != null ? Integer.valueOf(lead.IdNivelPagado__c) : 0;
            candidatoInfo.programaPagado = lead.IdProgramaPagado__c != null ? Integer.valueOf(lead.IdProgramaPagado__c) : 0;
            candidatoInfo.grupoPagado = lead.IdGrupoPagado__c != null ? Integer.valueOf(lead.IdGrupoPagado__c) : 0;
            
            ls.CandidatoInfo.add(candidatoInfo);
        }
        return ls;
    }
    
    public IEU_ERPMaster.ArrayOfGrupoInfo addGrupoInfo(List<sObject> sobjects) {
        IEU_ERPMaster.ArrayOfGrupoInfo ls = new IEU_ERPMaster.ArrayOfGrupoInfo();
        ls.GrupoInfo = new List<IEU_ERPMaster.GrupoInfo>();
        for(sObject obj: sobjects) {
            Grupo__c grupo = (Grupo__c) obj;
            IEU_ERPMaster.GrupoInfo gi = new IEU_ERPMaster.GrupoInfo();
           
            gi.idGrupo = grupo.IdGrupo__c != null ? Integer.valueOf(grupo.IdGrupo__c) : 0;
            gi.idPlantel = grupo.OfertaEducativa__r.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(grupo.OfertaEducativa__r.Plantel__r.IdInterno__c)) : 0;
            gi.periodo = grupo.OfertaEducativa__r.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.Periodo__r.IdPeriodo__c) : 0;
            
           
            gi.programa = grupo.OfertaEducativa__r.Programa__r.IdInterno__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.Programa__r.IdInterno__c) : 0;
            gi.nivel = grupo.OfertaEducativa__r.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(grupo.OfertaEducativa__r.Nivel__r.IdInternoNivel__c)) : 0;
            gi.idTurno = grupo.IdTurno__c != null ? Integer.valueOf(String.valueOf(grupo.IdTurno__c)) : 0;
            gi.modalidad = grupo.OfertaEducativa__r.RvoeVigente__r.idModalidadProg__c  != null ? grupo.OfertaEducativa__r.RvoeVigente__r.idModalidadProg__c : '';  
            gi.periodicidad = grupo.Periodicidad__r.IdInternoPeriodicidad__c != null ? Integer.valueOf(String.valueOf(grupo.Periodicidad__r.IdInternoPeriodicidad__c)) : 0;
            gi.fechaRegistro = grupo.FechaRegistro__c != null ? String.valueOf(grupo.FechaRegistro__c) : '0000-00-00';
            gi.fechaInicio = grupo.FechaInicioClases__c != null ? String.valueOf(grupo.FechaInicioClases__c) : '0000-00-00';
            gi.activo = grupo.Activo__c != null && grupo.Activo__c == 'Activo' ? 1 : 0;
            gi.sede = grupo.Sede__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(grupo.Sede__r.IdInterno__c)) : 0;
            gi.sede1 = grupo.Sede__r.Name != null ? grupo.Sede__r.Name : 'a';
            if(gi.sede1.length() > 80) {
                gi.sede1 = gi.sede1.substring(0, 79);
            }
            gi.actualizar = 0; //FIJO PARA PRUEBAS DEEBE CAMBIARSE A ModificadoERP__c RJP
             
            /*
            	Validación para un grupo aperturado
            */
            if(grupo.Activo__c =='Activo' && grupo.Estatus__c == 'Autorizado' 
            		&& grupo.FechaApertura__c != null && grupo.UsuarioApertura__c != null 
            		&& grupo.Nomenclatura__c !=null && grupo.AperturaOperativo__c == true){
              
             		gi.grupo = grupo.Nomenclatura__c;
             		gi.aperturaOperativo = 1;
             		gi.usuarioApertura = grupo.UsuarioApertura__r.idInterno__c  != null ? String.valueOf(grupo.UsuarioApertura__r.idInterno__c) : '';
             		if(gi.usuarioApertura.length() > 50) {
		                gi.usuarioApertura = gi.usuarioApertura.substring(0, 49);
		            }
             		gi.fAperturaO = grupo.FechaApertura__c != null ? String.valueOf(grupo.FechaApertura__c)  : '0000-00-00';
            }else{//Que no está aperturado
            		gi.grupo = grupo.Nomenclatura__c != null ? gi.grupo = grupo.Nomenclatura__c : '';
            		gi.aperturaOperativo = 0;
            	    gi.usuarioApertura = grupo.UsuarioApertura__r.idInterno__c  != null ? String.valueOf(grupo.UsuarioApertura__r.idInterno__c) : '';
            	    if(gi.usuarioApertura.length() > 50) {
		                gi.usuarioApertura = gi.usuarioApertura.substring(0, 49);
		            }
            	    gi.fAperturaO = grupo.FechaApertura__c != null ? String.valueOf(grupo.FechaApertura__c)  : '0000-00-00';
            }
            
            ls.GrupoInfo.add(gi);
            
        }
        return ls;
    }
    
    public IEU_ERPMaster.ArrayOfBecasInfo addBecasInfo(List<sObject> sobjects) {
        IEU_ERPMaster.ArrayOfBecasInfo ls = new IEU_ERPMaster.ArrayOfBecasInfo();
        ls.BecasInfo = new List<IEU_ERPMaster.BecasInfo>();
        for(sObject obj: sobjects) {
            Opportunity lead = (Opportunity) obj;
            IEU_ERPMaster.BecasInfo bi = new IEU_ERPMaster.BecasInfo();
            
            bi.usuario = lead.Owner.idInterno__c;
            if(bi.usuario.length() > 50) {
                bi.usuario = bi.usuario.substring(0, 49);
            }
            bi.folio = lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
            bi.idperiodo = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
            bi.idplantel = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Plantel__r.IdInterno__c)) : 0;
            bi.idnivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
            bi.idprograma = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
            bi.porcentaje = lead.PorcentajeBeca__c != null ? Integer.valueOf(String.valueOf(lead.PorcentajeBeca__c)) : 0;
            bi.valor = lead.ValorLetra__c != null ? Integer.valueOf(String.valueOf(lead.ValorLetra__c)) : 0;
            if(lead.TipoBeca__c !=null && lead.TipoBeca__c.equals('Comercial')) {
                bi.esquema = 1;
                bi.idbeca = 276;
            }else if (lead.TipoBeca__c !=null && lead.TipoBeca__c.equals('Convenio')){
                bi.esquema = 2;
                bi.idbeca = Integer.valueOf(lead.Beca__r.IdInternoConvenio__c) != null ? Integer.valueOf(lead.Beca__r.IdInternoConvenio__c) : 0;
            }else {
                bi.esquema =0;
            } 
            Datetime auxFechaRegistro = getDateRegistroBeca(lead.Id,lead.FechaOtorgaBeca__c);
            bi.fecharegistro = auxFechaRegistro != null ? auxFechaRegistro.format('yyyy-MM-dd') :  lead.CreatedDate.format('yyyy-MM-dd');
            bi.usuarioRegistra =  lead.UsuarioOtorgaBeca__c != null ? lead.UsuarioOtorgaBeca__c : lead.Owner.IDInterno__c;
            if(bi.usuarioRegistra.length() > 50) {
                bi.usuarioRegistra = bi.usuarioRegistra.substring(0, 49);
            }
            bi.usuarioAutoriza = getAprobadorBececa( lead.Id,  lead.OwnerId);
            
            if(bi.usuarioAutoriza.length() > 50) {
                bi.usuarioAutoriza = bi.usuarioAutoriza.substring(0, 49);
            }
            
            bi.fechaAutorizacion = getDateAprobadorBeca(lead.Id) != null ? getDateAprobadorBeca(lead.Id).format('yyyy-MM-dd') : lead.CreatedDate.format('yyyy-MM-dd');//PENDIENTE
            bi.actualizar = lead.ModificadoERP__c ? 1 : 0;
            if(lead.TipoBeca__c == 'Comercial' && (lead.LetraBeca__c != null && lead.LetraBeca__c != '')){
            	 ls.BecasInfo.add(bi);
            }else if (lead.TipoBeca__c == 'Convenio'){
            	ls.BecasInfo.add(bi);
            }
        }
        return ls;
    }
    
    
    //idOpp = id de la oportunidad
    //idOppOwner = id salesforce del propietario de la oportunidad
    
    public String getAprobadorBececa(String idOpp, String idOppOwner){
        String idAprobador = '';
        String idSolicituBeca = '';
        list<SolicitudBeca__c> solicitudesBeca = new list<SolicitudBeca__c>();
        try{
            solicitudesBeca = [SELECT id FROM SolicitudBeca__c WHERE Oportunidad__c =: idOpp  ORDER BY CreatedDate DESC];
        }catch(Exception e){
            
        }
        if(solicitudesBeca.size() > 0){
            idSolicituBeca = solicitudesBeca[0].Id;
        }
        
        
        list<ProcessInstance> procesess = new list<ProcessInstance>();
        try{
            procesess = [select LastActorId,TargetObjectId,Status,CompletedDate from ProcessInstance WHERE TargetObjectId =: idSolicituBeca AND Status = 'Approved'];
        }catch(Exception e){
            
        }
        if(procesess.size() > 0){
            String idUsuario = '';
            idUsuario = procesess.get(0).LastActorId;
            try{
                User user = [SELECT Id,IdInterno__c FROM User WHERE Id =:  idUsuario ];
                idAprobador = user.IdInterno__c;
            }catch(Exception e){
            }
        }else if (idOppOwner != null){
            try{
                User user = [SELECT Id,IdInterno__c FROM User WHERE Id =:  idOppOwner ];
                idAprobador = user.IdInterno__c;
            }catch(Exception e){
            }
        }
        return idAprobador;
    }
    
    
    public Datetime getDateAprobadorBeca(String idOpp){
        Datetime dateAprobadorBececa = null;
        String idSolicituBeca = '';
        list<SolicitudBeca__c> solicitudesBeca = new list<SolicitudBeca__c>();
        try{
            solicitudesBeca = [SELECT id FROM SolicitudBeca__c WHERE Oportunidad__c =: idOpp  ORDER BY CreatedDate DESC];
        }catch(Exception e){
            
        }
        if(solicitudesBeca.size() > 0){
            idSolicituBeca = solicitudesBeca[0].Id;
        }
        
        
        list<ProcessInstance> procesess = new list<ProcessInstance>();
        try{
            procesess = [select LastActorId,TargetObjectId,Status,CompletedDate from ProcessInstance WHERE TargetObjectId =: idSolicituBeca AND Status = 'Approved'];
        }catch(Exception e){
            
        }
        if(procesess.size() > 0){
            dateAprobadorBececa = procesess.get(0).CompletedDate;
        }else{
            try{
                list<OpportunityFieldHistory>  history = [SELECT createdById, CreatedDate, Field, Id, IsDeleted, NewValue, OldValue, OpportunityId 
                						FROM OpportunityFieldHistory WHERE OpportunityId =: idOpp AND Field = 'PorcentajeBeca__c' order by CreatedDate DESC];
               	dateAprobadorBececa =  history.get(0).CreatedDate;
               	//datetime auxDate = history.get(0).CreatedDate;
                //dateAprobadorBececa = date.newinstance(auxDate.year(), auxDate.month(), auxDate.day()); 
            }catch(Exception e){
            }
        }
        return dateAprobadorBececa;
    }
    
      public Datetime getDateRegistroBeca(String idOpp,DateTime fechaRegistro){
        Datetime dateRegistroBececa = null;
        String idSolicituBeca = '';
        list<SolicitudBeca__c> solicitudesBeca = new list<SolicitudBeca__c>();
        try{
            solicitudesBeca = [SELECT id,CreatedDate FROM SolicitudBeca__c WHERE Oportunidad__c =: idOpp  ORDER BY CreatedDate DESC];
        }catch(Exception e){
            
        }
        if(solicitudesBeca.size() > 0){
            dateRegistroBececa = solicitudesBeca[0].CreatedDate;
        }else{
        	dateRegistroBececa = fechaRegistro;
        }
        
        
        
        return dateRegistroBececa;
    }
    
    public IEU_ERPMaster.ArrayOfPagosGrupoInfo addPagosGrupoInfo(List<sObject> sobjects) {
        IEU_ERPMaster.ArrayOfPagosGrupoInfo ls = new IEU_ERPMaster.ArrayOfPagosGrupoInfo();
        ls.PagosGrupoInfo = new List<IEU_ERPMaster.PagosGrupoInfo>();
        
        list<Grupo__c> listaGrupo  = new list<Grupo__c>();
        for(sObject obj: sobjects) {
            Grupo__c grupo = (Grupo__c) obj;
            listaGrupo.add(grupo);
        }
        
        map<String,list<OfertaConceptoPagos__c>> mapOfertaConConceptos = new map<String,list<OfertaConceptoPagos__c>>();
        set<String> idsOfertas = new set<String>();
        map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
        
        for(Grupo__c grupo  : listaGrupo){
            mapGrupo.put(grupo.id,grupo);
            idsOfertas.add(grupo.OfertaEducativa__c);
        }
        
        
        
        map<String,OfertaConceptoPagos__c> mapAuxOfertaConceptoPago = new map<String,OfertaConceptoPagos__c>();
        list<OfertaConceptoPagos__c> listaOCP  = new list<OfertaConceptoPagos__c>();
        
        String  queryOfertaConcepto = 'SELECT Id,Activo__c,OfertaEducativa__c,Cantidad__c,Monto__c,ConceptoPago__c,ConceptoPago__r.Name,ConceptoPago__r.IdInternoConcepto__c ' +
        				 ' FROM OfertaConceptoPagos__c ' + 
        				 ' WHERE OfertaEducativa__c IN : idsOfertas AND Activo__c = true AND ' +
        				 ' (EnviadoERPGrupoPago__c =false OR (EnviadoERPGrupoPago__c =true AND ModificadoERPGrupoPago__c  = true )) ';  
       try{ 				 
       	listaOCP  = Database.query(queryOfertaConcepto); 
       }catch(Exception e){
       
       }
       
       if(listaOCP.size() > 0){
            for(OfertaConceptoPagos__c ocp : [SELECT Id,Activo__c,OfertaEducativa__c,Cantidad__c,Monto__c,ConceptoPago__c,ConceptoPago__r.Name,ConceptoPago__r.IdInternoConcepto__c FROM OfertaConceptoPagos__c WHERE OfertaEducativa__c IN : idsOfertas AND Activo__c = true and   (EnviadoERPGrupoPago__c =false OR (EnviadoERPGrupoPago__c =true AND ModificadoERPGrupoPago__c  =true ))  ]){
                String keyAux = ocp.ConceptoPago__c + '' +ocp.OfertaEducativa__c;
                mapAuxOfertaConceptoPago.put(keyAux,ocp);
            }
            
            for(OfertaConceptoPagos__c ocp : mapAuxOfertaConceptoPago.values()){
                if(!mapOfertaConConceptos.containsKey(ocp.OfertaEducativa__c)){
                    mapOfertaConConceptos.put(ocp.OfertaEducativa__c,new list<OfertaConceptoPagos__c>());
                }
                mapOfertaConConceptos.get(ocp.OfertaEducativa__c).add(ocp);
            }
            
            for(Grupo__c grupo  : listaGrupo){
                for(OfertaConceptoPagos__c ocp : mapOfertaConConceptos.get(grupo.OfertaEducativa__c)){
                    
                    IEU_ERPMaster.PagosGrupoInfo pgi = new IEU_ERPMaster.PagosGrupoInfo();
                    pgi.idGrupo = grupo.IdGrupo__c != null ? Integer.valueOf(grupo.IdGrupo__c) : 0;
                    pgi.concepto = Integer.valueOf(ocp.ConceptoPago__r.IdInternoConcepto__c) !=null ? Integer.valueOf(ocp.ConceptoPago__r.IdInternoConcepto__c):0;
                    Integer cant = 1;
                    if(ocp.ConceptoPago__r.Name == 'Colegiatura') {
                        cant = grupo.OfertaEducativa__r != null && grupo.OfertaEducativa__r.NumeroColegiaturas__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.NumeroColegiaturas__c) : 0;
                        
                    } else if(ocp.ConceptoPago__r.Name == 'Inscripción') { 
                        cant = grupo.OfertaEducativa__r != null && grupo.OfertaEducativa__r.NumeroInscripciones__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.NumeroInscripciones__c) : 0;
                        
                    } 
                    pgi.cantidad = cant;
                    pgi.costo = Double.valueOf(ocp.Monto__c);
                    //pgi.actualizar = grupo.ModificadoERPGrupoPago__c ? 1 : 0;
                    pgi.actualizar = 0 ;//FIJO PARA PRUEBAS DEEBE CAMBIARSE A ModificadoERP__c RJP
                    ls.PagosGrupoInfo.add(pgi);
                }
                
            }
            
            
        }
        
        
        return ls;        
    }
    
    
    
   public IEU_ERPMaster.ArrayOfPagosInscripcionInfo addPagosInscripcionInfo(List<sObject> sobjects) {
        IEU_ERPMaster.ArrayOfPagosInscripcionInfo ls = new IEU_ERPMaster.ArrayOfPagosInscripcionInfo();
        ls.PagosInscripcionInfo = new List<IEU_ERPMaster.PagosInscripcionInfo>();
        set<String> idsOportunidades = new set<String>();
        set<String> idsOfertas = new set<String>();
        String sidsOporunidades = '';
        list<Opportunity> oportunidades = new List<Opportunity>();
        map<String,list<FichaPago__c>> mapOppFichas = new  map<String,list<FichaPago__c>>();
        set<String> tipodFichaIncluidos = new set<String>();
        
        for(sObject obj: sobjects) {
            FichaPago__c ficha = (FichaPago__c) obj;
            IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
            idsOportunidades.add(ficha.Oportunidad__c);
            sidsOporunidades = sidsOporunidades + '\'' + ficha.Oportunidad__c + '\',';
        }
        sidsOporunidades = sidsOporunidades.removeEnd(',');
        String queryOpp = 'SELECT ' +  Utils.getStrCampos(Opportunity.SObjectType) + ',Plantel__r.IdInterno__c,Periodo__r.IdPeriodo__c,Nivel__r.Name FROM Opportunity WHERE id IN (' + sidsOporunidades +')';
        oportunidades = Database.query(queryOpp);

		 for(sObject obj: sobjects) {
            FichaPago__c ficha = (FichaPago__c) obj;
            if(!mapOppFichas.containsKey(ficha.Oportunidad__c)){
            	mapOppFichas.put(ficha.Oportunidad__c, new list<FichaPago__c>());
            }
            mapOppFichas.get(ficha.Oportunidad__c).add(ficha);
		 }
	    
        
        for(Opportunity opp : oportunidades){
           for(FichaPago__c fichaPago : mapOppFichas.get(opp.Id)){
           		String idBanco = '0';
           		
	           	if (fichaPago.TipoFicha__c == 'Ficha Especial'){
	           			IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
	           			idBanco = String.valueOf(fichaPago.idbanco__c);
	                    pii.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
	                    pii.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
	                    pii.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
	                    pii.actualizar = 0;
                    	pii.concepto = 99;
                    	pii.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
                        pii.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0;
                        pii.cantidad = fichaPago.MontoPagado__c;
                        idBanco = String.valueOf(fichaPago.idbanco__c); 
                        pii.idBanco =  Integer.valueOf(idBanco);
                        pii.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
                    	if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
                            pii.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
                        }else{
                            pii.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
                        }
                        ls.PagosInscripcionInfo.add(pii);
	           	}
	           	if(opp.Nivel__r.Name  != 'Doctorado' && opp.AplicaPromocionCero__c && fichaPago.TipoFicha__c != 'Ficha Especial'){ //Si aplica promocion cero y es diferente de doctorado  es COLEGIATURA con descuento
	           			IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
	           			pii.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
	                    pii.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
	                    pii.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
	           		 	pii.concepto = 3;
	                    pii.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
	                    idBanco = String.valueOf(fichaPago.idbanco__c); 
	                    pii.idBanco =  Integer.valueOf(idBanco);
	                    pii.actualizar = 0;
	                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
	                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
	                    }else{
	                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
	                    }
	                    pii.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
	                    pii.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
	                    pii.cantidad = fichaPago.MontoPagado__c;
	                    ls.PagosInscripcionInfo.add(pii);
	                    //La inscripcion se manda en 0 pesos
	                    IEU_ERPMaster.PagosInscripcionInfo piiCero = new IEU_ERPMaster.PagosInscripcionInfo();
	           			piiCero.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
	                    piiCero.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
	                    piiCero.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
	           		 	piiCero.concepto = 2;
	                    piiCero.idFormaPago = Integer.valueOf(fichaPago.IdFormaPago__c);
	                    idBanco = String.valueOf(fichaPago.idbanco__c); 
	                    piiCero.idBanco =  Integer.valueOf(idBanco);
	                    piiCero.actualizar = 0;
	                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
	                        piiCero.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
	                    }else{
	                        piiCero.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
	                    }
	                    piiCero.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
	                    piiCero.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
	                    piiCero.cantidad = 0;
	                    ls.PagosInscripcionInfo.add(piiCero);
	           	}else if(opp.Nivel__r.Name  != 'Doctorado' && !opp.AplicaPromocionCero__c && fichaPago.TipoFicha__c != 'Ficha Especial'){ //Si NO aplica promocion cero y es diferente de doctorado  es INSCRIPCION con descuento
	           			IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
	           			pii.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
	                    pii.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
	                    pii.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
	           		 	pii.concepto = 2;
	                    pii.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
	                    idBanco = String.valueOf(fichaPago.idbanco__c); 
	                    pii.idBanco =  Integer.valueOf(idBanco);
	                    pii.actualizar = 0;
	                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
	                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
	                    }else{
	                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
	                    }
	                    pii.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
	                    pii.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
	                    pii.cantidad = fichaPago.MontoPagado__c;
	                    ls.PagosInscripcionInfo.add(pii);
	           	}else if(opp.Nivel__r.Name == 'Doctorado' && !opp.AplicaPromocionCero__c  && fichaPago.TipoFicha__c != 'Ficha Especial'){ //Si NO aplica promocion cero y es  de doctorado
	           		   if(fichaPago.TipoFicha__c == 'Pago Online'){
		           		    IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
		           			pii.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
		                    pii.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
		                    pii.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
		           		 	Decimal decMonto = fichaPago.MontoPagado__c;
		           		 	Decimal decExamen= opp.ExamenAdmision__c;

		           		 	if(!tipodFichaIncluidos.contains('Pago Online' + opp.Id + '1') && decMonto.round(System.RoundingMode.DOWN) == decExamen.round(System.RoundingMode.DOWN) ){
		           		 		pii.concepto = 1;//EXAMEN ADMISION
		           		 	}else{
		           		 		pii.concepto = 2;//INSCRIPCION
		           		 	}
		                    pii.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
		                    idBanco = String.valueOf(fichaPago.idbanco__c); 
		                    pii.idBanco =  Integer.valueOf(idBanco);
		                    pii.actualizar = 0;
		                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
		                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
		                    }else{
		                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
		                    }
		                    pii.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
		                    pii.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
		                    pii.cantidad = fichaPago.MontoPagado__c;
		                    tipodFichaIncluidos.add('Pago Online' + opp.Id + pii.concepto);
		                    ls.PagosInscripcionInfo.add(pii);
	           		   }else if(fichaPago.TipoFicha__c == 'Nivel Doctorado'){
	           		   		IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
		           			pii.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
		                    pii.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
		                    pii.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
		           		 	pii.concepto = 1; //EXAMEN ADMISION
		                    pii.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
		                    idBanco = String.valueOf(fichaPago.idbanco__c); 
		                    pii.idBanco =  Integer.valueOf(idBanco);
		                    pii.actualizar = 0;
		                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
		                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
		                    }else{
		                        pii.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
		                    }
		                    pii.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
		                    pii.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
		                    pii.cantidad = opp.ExamenAdmision__c;
		                    ls.PagosInscripcionInfo.add(pii);
		                    /*Inscripcion*/
		                    IEU_ERPMaster.PagosInscripcionInfo piiInscripcion = new IEU_ERPMaster.PagosInscripcionInfo();
		           			piiInscripcion.folio = Integer.valueOf(fichaPago.FolioLead__c) != null ? Integer.valueOf(fichaPago.FolioLead__c) : 0;
		                    piiInscripcion.periodo = Integer.valueOf(opp.Periodo__r.IdPeriodo__c) != null ? Integer.valueOf(opp.Periodo__r.IdPeriodo__c) : 0;
		                    piiInscripcion.idPlantel = Integer.valueOf(opp.Plantel__r.IdInterno__c) != null ?  Integer.valueOf(opp.Plantel__r.IdInterno__c) : 0;
		           		 	piiInscripcion.concepto = 2;//INSCRIPCION
		                    piiInscripcion.idFormaPago = Integer.valueOf(FichaPago.IdFormaPago__c);
		                    idBanco = String.valueOf(fichaPago.idbanco__c); 
		                    piiInscripcion.idBanco =  Integer.valueOf(idBanco);
		                    piiInscripcion.actualizar = 0;
		                    if(fichaPago.NumeroAutorizacion__c != null && fichaPago.NumeroAutorizacion__c.length() > 80 ) {
		                        piiInscripcion.numAutorizacion = fichaPago.NumeroAutorizacion__c.substring(0, 79);
		                    }else{
		                        piiInscripcion.numAutorizacion = fichaPago.NumeroAutorizacion__c != null ? fichaPago.NumeroAutorizacion__c : '';
		                    }
		                    piiInscripcion.fechaPago = fichaPago.FechaPago__c != null ? String.valueOf(fichaPago.FechaPago__c) : '';
		                    piiInscripcion.tipoTarjeta = fichaPago.TipoTarjeta__c != null ? Integer.valueOf(fichaPago.IdTipoTarjetaPago__c) : 0; 
		                    piiInscripcion.cantidad = opp.InscripcionDescuento__c;
		                    ls.PagosInscripcionInfo.add(piiInscripcion);
	           		   }
	           	}
	           
           } 
        }
        return ls;
    }
}