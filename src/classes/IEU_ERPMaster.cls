//Generated by wsdl2apex

public class IEU_ERPMaster {
    public class GrupoInfo {
        public Integer idGrupo;
        public Integer idPlantel;
        public Integer periodo;
        public String grupo;
        public Integer programa;
        public Integer nivel;
        public Integer idTurno;
        public String modalidad;
        public Integer periodicidad;
        public String fechaRegistro;
        public String fechaInicio;
        public Integer activo;
        public Integer aperturaOperativo;
        public String usuarioApertura;
        public String fAperturaO;
        public Integer sede;
        public String sede1;
        public Integer actualizar;
        private String[] idGrupo_type_info = new String[]{'idGrupo','http://tempuri.org/',null,'1','1','false'};
        private String[] idPlantel_type_info = new String[]{'idPlantel','http://tempuri.org/',null,'1','1','false'};
        private String[] periodo_type_info = new String[]{'periodo','http://tempuri.org/',null,'1','1','false'};
        private String[] grupo_type_info = new String[]{'grupo','http://tempuri.org/',null,'0','1','false'};
        private String[] programa_type_info = new String[]{'programa','http://tempuri.org/',null,'1','1','false'};
        private String[] nivel_type_info = new String[]{'nivel','http://tempuri.org/',null,'1','1','false'};
        private String[] idTurno_type_info = new String[]{'idTurno','http://tempuri.org/',null,'1','1','false'};
        private String[] modalidad_type_info = new String[]{'modalidad','http://tempuri.org/',null,'0','1','false'};
        private String[] periodicidad_type_info = new String[]{'periodicidad','http://tempuri.org/',null,'1','1','false'};
        private String[] fechaRegistro_type_info = new String[]{'fechaRegistro','http://tempuri.org/',null,'0','1','false'};
        private String[] fechaInicio_type_info = new String[]{'fechaInicio','http://tempuri.org/',null,'0','1','false'};
        private String[] activo_type_info = new String[]{'activo','http://tempuri.org/',null,'1','1','false'};
        private String[] aperturaOperativo_type_info = new String[]{'aperturaOperativo','http://tempuri.org/',null,'1','1','false'};
        private String[] usuarioApertura_type_info = new String[]{'usuarioApertura','http://tempuri.org/',null,'0','1','false'};
        private String[] fAperturaO_type_info = new String[]{'fAperturaO','http://tempuri.org/',null,'0','1','false'};
        private String[] sede_type_info = new String[]{'sede','http://tempuri.org/',null,'1','1','false'};
        private String[] sede1_type_info = new String[]{'sede1','http://tempuri.org/',null,'0','1','false'};
        private String[] actualizar_type_info = new String[]{'actualizar','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'idGrupo','idPlantel','periodo','grupo','programa','nivel','idTurno','modalidad','periodicidad','fechaRegistro','fechaInicio','activo','aperturaOperativo','usuarioApertura','fAperturaO','sede','sede1','actualizar'};
    }
    public class AddGrupoInfoResponse_element {
        public String AddGrupoInfoResult;
        private String[] AddGrupoInfoResult_type_info = new String[]{'AddGrupoInfoResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddGrupoInfoResult'};
    }
    public class AddPagosGrupoInfoResponse_element {
        public String AddPagosGrupoInfoResult;
        private String[] AddPagosGrupoInfoResult_type_info = new String[]{'AddPagosGrupoInfoResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddPagosGrupoInfoResult'};
    }
    public class AddCandidatoInfo_element {
        public String usuario;
        public String pwd;
        public IEU_ERPMaster.ArrayOfCandidatoInfo CandidatoInfo;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] pwd_type_info = new String[]{'pwd','http://tempuri.org/',null,'0','1','false'};
        private String[] CandidatoInfo_type_info = new String[]{'CandidatoInfo','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','pwd','CandidatoInfo'};
    }
    public class BecasInfo {
        public String usuario;
        public Integer folio;
        public Integer idperiodo;
        public Integer idplantel;
        public Integer idnivel;
        public Integer idprograma;
        public Integer idbeca;
        public Integer porcentaje;
        public Integer valor;
        public String fecharegistro;
        public String usuarioRegistra;
        public Integer esquema;
        public String usuarioAutoriza;
        public String fechaAutorizacion;
        public Integer actualizar;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] folio_type_info = new String[]{'folio','http://tempuri.org/',null,'1','1','false'};
        private String[] idperiodo_type_info = new String[]{'idperiodo','http://tempuri.org/',null,'1','1','false'};
        private String[] idplantel_type_info = new String[]{'idplantel','http://tempuri.org/',null,'1','1','false'};
        private String[] idnivel_type_info = new String[]{'idnivel','http://tempuri.org/',null,'1','1','false'};
        private String[] idprograma_type_info = new String[]{'idprograma','http://tempuri.org/',null,'1','1','false'};
        private String[] idbeca_type_info = new String[]{'idbeca','http://tempuri.org/',null,'1','1','false'};
        private String[] porcentaje_type_info = new String[]{'porcentaje','http://tempuri.org/',null,'1','1','false'};
        private String[] valor_type_info = new String[]{'valor','http://tempuri.org/',null,'1','1','false'};
        private String[] fecharegistro_type_info = new String[]{'fecharegistro','http://tempuri.org/',null,'0','1','false'};
        private String[] usuarioRegistra_type_info = new String[]{'usuarioRegistra','http://tempuri.org/',null,'0','1','false'};
        private String[] esquema_type_info = new String[]{'esquema','http://tempuri.org/',null,'1','1','false'};
        private String[] usuarioAutoriza_type_info = new String[]{'usuarioAutoriza','http://tempuri.org/',null,'0','1','false'};
        private String[] fechaAutorizacion_type_info = new String[]{'fechaAutorizacion','http://tempuri.org/',null,'0','1','false'};
        private String[] actualizar_type_info = new String[]{'actualizar','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','folio','idperiodo','idplantel','idnivel','idprograma','idbeca','porcentaje','valor','fecharegistro','usuarioRegistra','esquema','usuarioAutoriza','fechaAutorizacion','actualizar'};
    }
    public class Hola_element {
        public String nombre;
        private String[] nombre_type_info = new String[]{'nombre','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'nombre'};
    }
    public class AddPagosInscripcionInfo_element {
        public String usuario;
        public String pwd;
        public IEU_ERPMaster.ArrayOfPagosInscripcionInfo PagosInscripcionInfo;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] pwd_type_info = new String[]{'pwd','http://tempuri.org/',null,'0','1','false'};
        private String[] PagosInscripcionInfo_type_info = new String[]{'PagosInscripcionInfo','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','pwd','PagosInscripcionInfo'};
    }
    public class ArrayOfBecasInfo {
        public IEU_ERPMaster.BecasInfo[] BecasInfo;
        private String[] BecasInfo_type_info = new String[]{'BecasInfo','http://tempuri.org/',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'BecasInfo'};
    }
    public class ArrayOfGrupoInfo {
        public IEU_ERPMaster.GrupoInfo[] GrupoInfo;
        private String[] GrupoInfo_type_info = new String[]{'GrupoInfo','http://tempuri.org/',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'GrupoInfo'};
    }
    public class PagosInscripcionInfo {
        public Double folio;
        public Integer periodo;
        public Integer idPlantel;
        public Integer concepto;
        public Integer idFormaPago;
        public Integer idBanco;
        public Double cantidad;
        public String numAutorizacion;
        public String fechaPago;
        public Integer tipoTarjeta;
        public Integer actualizar;
        public String idConceptoPago;
        public Boolean disponiblePromocionCero; 
        
        private String[] disponiblePromocionCero_type_info = new String[]{'disponiblePromocionCero','http://tempuri.org/',null,'1','1','false'};
        private String[] idConceptoPago_type_info = new String[]{'idConceptoPago','http://tempuri.org/',null,'1','1','false'};
        private String[] folio_type_info = new String[]{'folio','http://tempuri.org/',null,'1','1','false'};
        private String[] periodo_type_info = new String[]{'periodo','http://tempuri.org/',null,'1','1','false'};
        private String[] idPlantel_type_info = new String[]{'idPlantel','http://tempuri.org/',null,'1','1','false'};
        private String[] concepto_type_info = new String[]{'concepto','http://tempuri.org/',null,'1','1','false'};
        private String[] idFormaPago_type_info = new String[]{'idFormaPago','http://tempuri.org/',null,'1','1','false'};
        private String[] idBanco_type_info = new String[]{'idBanco','http://tempuri.org/',null,'1','1','false'};
        private String[] cantidad_type_info = new String[]{'cantidad','http://tempuri.org/',null,'1','1','false'};
        private String[] numAutorizacion_type_info = new String[]{'numAutorizacion','http://tempuri.org/',null,'0','1','false'};
        private String[] fechaPago_type_info = new String[]{'fechaPago','http://tempuri.org/',null,'0','1','false'};
        private String[] tipoTarjeta_type_info = new String[]{'tipoTarjeta','http://tempuri.org/',null,'1','1','false'};
        private String[] actualizar_type_info = new String[]{'actualizar','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'folio','periodo','idPlantel','concepto','idFormaPago','idBanco','cantidad','numAutorizacion','fechaPago','tipoTarjeta','actualizar'};
    }
    public class AddCandidatoInfoResponse_element {
        public String AddCandidatoInfoResult;
        private String[] AddCandidatoInfoResult_type_info = new String[]{'AddCandidatoInfoResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddCandidatoInfoResult'};
    }
    public class PagosGrupoInfo {
        public Integer idGrupo;
        public Integer concepto;
        public Integer cantidad;
       public Double costo;
      
        public Integer actualizar;
        private String[] idGrupo_type_info = new String[]{'idGrupo','http://tempuri.org/',null,'1','1','false'};
        private String[] concepto_type_info = new String[]{'concepto','http://tempuri.org/',null,'1','1','false'};
        private String[] cantidad_type_info = new String[]{'cantidad','http://tempuri.org/',null,'1','1','false'};
        private String[] costo_type_info = new String[]{'costo','http://tempuri.org/',null,'1','1','false'};
        private String[] actualizar_type_info = new String[]{'actualizar','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'idGrupo','concepto','cantidad','costo','actualizar'};
    }
    public class AddGrupoInfo_element {
        public String usuario;
        public String pwd;
        public IEU_ERPMaster.ArrayOfGrupoInfo GrupoInfo;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] pwd_type_info = new String[]{'pwd','http://tempuri.org/',null,'0','1','false'};
        private String[] GrupoInfo_type_info = new String[]{'GrupoInfo','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','pwd','GrupoInfo'};
    }
    public class AddBecasInfo_element {
        public String usuario;
        public String pwd;
        public IEU_ERPMaster.ArrayOfBecasInfo BecasInfo;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] pwd_type_info = new String[]{'pwd','http://tempuri.org/',null,'0','1','false'};
        private String[] BecasInfo_type_info = new String[]{'BecasInfo','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','pwd','BecasInfo'};
    }
    public class ArrayOfPagosGrupoInfo {
        public IEU_ERPMaster.PagosGrupoInfo[] PagosGrupoInfo;
        private String[] PagosGrupoInfo_type_info = new String[]{'PagosGrupoInfo','http://tempuri.org/',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'PagosGrupoInfo'};
    }
    public class ArrayOfPagosInscripcionInfo {
        public IEU_ERPMaster.PagosInscripcionInfo[] PagosInscripcionInfo;
        private String[] PagosInscripcionInfo_type_info = new String[]{'PagosInscripcionInfo','http://tempuri.org/',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'PagosInscripcionInfo'};
    }
    public class AddBecasInfoResponse_element {
        public String AddBecasInfoResult;
        private String[] AddBecasInfoResult_type_info = new String[]{'AddBecasInfoResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddBecasInfoResult'};
    }
    public class HolaResponse_element {
        public String HolaResult;
        private String[] HolaResult_type_info = new String[]{'HolaResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'HolaResult'};
    }
    public class AddPagosGrupoInfo_element {
        public String usuario;
        public String pwd;
        public IEU_ERPMaster.ArrayOfPagosGrupoInfo PagosGrupoInfo;
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] pwd_type_info = new String[]{'pwd','http://tempuri.org/',null,'0','1','false'};
        private String[] PagosGrupoInfo_type_info = new String[]{'PagosGrupoInfo','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'usuario','pwd','PagosGrupoInfo'};
    }
    public class ArrayOfCandidatoInfo {
        public IEU_ERPMaster.CandidatoInfo[] CandidatoInfo;
        private String[] CandidatoInfo_type_info = new String[]{'CandidatoInfo','http://tempuri.org/',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'CandidatoInfo'};
    }
    public class CandidatoInfo {
        public Integer folio;
        public Integer idprofesion;
        public Integer idpais;
        public Integer periodo;
        public String nombre;
        public String aPaterno;
        public String aMaterno;
        public String domicilio;
        public String colonia;
        public String ciudad;
        public Integer idEstado;
        public String cp;
        public String telCasa;
        public String telOficina;
        public String celular;
        public String mail;
        public Integer idPlantel;
        public Integer Prog1Nivel;
        public Integer Prog1Clave;
        public Integer idGrupo;
        public Integer pagado;
        public String usuario;
        public String fechaPago;
        public String fechaNac;
        public Integer idsexo;
        public Integer idedocivil;
        public String fRegistro;
        
        public Integer periodoPago;
        public Integer idPlantelPago;
        public Integer Prog1NivelPago;
        public Integer Prog1ClavePago;
        public Integer idGrupoPago;
        public Integer actualizar;
        
         public Integer periodoPagado;
         public Integer plantelPagado;
         public Integer nivelPagado;
         public Integer programaPagado;
         public Integer grupoPagado;
        
        private String[] folio_type_info = new String[]{'folio','http://tempuri.org/',null,'1','1','false'};
        private String[] idprofesion_type_info = new String[]{'idprofesion','http://tempuri.org/',null,'1','1','false'};
        private String[] idpais_type_info = new String[]{'idpais','http://tempuri.org/',null,'1','1','false'};
        private String[] periodo_type_info = new String[]{'periodo','http://tempuri.org/',null,'1','1','false'};
        private String[] nombre_type_info = new String[]{'nombre','http://tempuri.org/',null,'0','1','false'};
        private String[] aPaterno_type_info = new String[]{'aPaterno','http://tempuri.org/',null,'0','1','false'};
        private String[] aMaterno_type_info = new String[]{'aMaterno','http://tempuri.org/',null,'0','1','false'};
        private String[] domicilio_type_info = new String[]{'domicilio','http://tempuri.org/',null,'0','1','false'};
        private String[] colonia_type_info = new String[]{'colonia','http://tempuri.org/',null,'0','1','false'};
        private String[] ciudad_type_info = new String[]{'ciudad','http://tempuri.org/',null,'0','1','false'};
        private String[] idEstado_type_info = new String[]{'idEstado','http://tempuri.org/',null,'1','1','false'};
        private String[] cp_type_info = new String[]{'cp','http://tempuri.org/',null,'0','1','false'};
        private String[] telCasa_type_info = new String[]{'telCasa','http://tempuri.org/',null,'0','1','false'};
        private String[] telOficina_type_info = new String[]{'telOficina','http://tempuri.org/',null,'0','1','false'};
        private String[] celular_type_info = new String[]{'celular','http://tempuri.org/',null,'0','1','false'};
        private String[] mail_type_info = new String[]{'mail','http://tempuri.org/',null,'0','1','false'};
        private String[] idPlantel_type_info = new String[]{'idPlantel','http://tempuri.org/',null,'1','1','false'};
        private String[] Prog1Nivel_type_info = new String[]{'Prog1Nivel','http://tempuri.org/',null,'1','1','false'};
        private String[] Prog1Clave_type_info = new String[]{'Prog1Clave','http://tempuri.org/',null,'1','1','false'};
        private String[] idGrupo_type_info = new String[]{'idGrupo','http://tempuri.org/',null,'1','1','false'};
        private String[] pagado_type_info = new String[]{'pagado','http://tempuri.org/',null,'1','1','false'};
        private String[] usuario_type_info = new String[]{'usuario','http://tempuri.org/',null,'0','1','false'};
        private String[] fechaPago_type_info = new String[]{'fechaPago','http://tempuri.org/',null,'0','1','false'};
        private String[] fechaNac_type_info = new String[]{'fechaNac','http://tempuri.org/',null,'0','1','false'};
        private String[] idsexo_type_info = new String[]{'idsexo','http://tempuri.org/',null,'1','1','false'};
        private String[] idedocivil_type_info = new String[]{'idedocivil','http://tempuri.org/',null,'1','1','false'};
        private String[] fRegistro_type_info = new String[]{'fRegistro','http://tempuri.org/',null,'0','1','false'};
        private String[] periodoPago_type_info = new String[]{'periodoPago','http://tempuri.org/',null,'1','1','false'};
        private String[] idPlantelPago_type_info = new String[]{'idPlantelPago','http://tempuri.org/',null,'1','1','false'};
        private String[] Prog1NivelPago_type_info = new String[]{'Prog1NivelPago','http://tempuri.org/',null,'1','1','false'};
        private String[] Prog1ClavePago_type_info = new String[]{'Prog1ClavePago','http://tempuri.org/',null,'1','1','false'};
        private String[] idGrupoPago_type_info = new String[]{'idGrupoPago','http://tempuri.org/',null,'1','1','false'};
        private String[] actualizar_type_info = new String[]{'actualizar','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'folio','idprofesion','idpais','periodo','nombre','aPaterno','aMaterno','domicilio','colonia','ciudad','idEstado','cp','telCasa','telOficina','celular','mail','idPlantel','Prog1Nivel','Prog1Clave','idGrupo','pagado','usuario','fechaPago','fechaNac','idsexo','idedocivil','fRegistro','periodoPago','idPlantelPago','Prog1NivelPago','Prog1ClavePago','idGrupoPago','actualizar'};
            
        private String[] periodoPagado_type_info = new String[]{'periodoPagado','http://tempuri.org/',null,'1','1','false'};     
        private String[] plantelPagado_type_info = new String[]{'plantelPagado','http://tempuri.org/',null,'1','1','false'};     
        private String[] nivelPagado_type_info = new String[]{'nivelPagado','http://tempuri.org/',null,'1','1','false'};     
        private String[] programaPagado_type_info = new String[]{'programaPagado','http://tempuri.org/',null,'1','1','false'};     
        private String[] grupoPagado_type_info = new String[]{'grupoPagado','http://tempuri.org/',null,'1','1','false'};     
       
    }
    public class AddPagosInscripcionInfoResponse_element {
        public String AddPagosInscripcionInfoResult;
        private String[] AddPagosInscripcionInfoResult_type_info = new String[]{'AddPagosInscripcionInfoResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddPagosInscripcionInfoResult'};
    }
    public class serviceSoap {
        public String endpoint_x = 'http://bck2.ieu.edu.mx/webServiceSalesforce/service.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://tempuri.org/', 'IEU_ERPMaster'};
        public String AddPagosGrupoInfo(String usuario,String pwd,IEU_ERPMaster.ArrayOfPagosGrupoInfo PagosGrupoInfo) {
            IEU_ERPMaster.AddPagosGrupoInfo_element request_x = new IEU_ERPMaster.AddPagosGrupoInfo_element();
            request_x.usuario = usuario;
            request_x.pwd = pwd;
            request_x.PagosGrupoInfo = PagosGrupoInfo;
            IEU_ERPMaster.AddPagosGrupoInfoResponse_element response_x;
            Map<String, IEU_ERPMaster.AddPagosGrupoInfoResponse_element> response_map_x = new Map<String, IEU_ERPMaster.AddPagosGrupoInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/AddPagosGrupoInfo',
              'http://tempuri.org/',
              'AddPagosGrupoInfo',
              'http://tempuri.org/',
              'AddPagosGrupoInfoResponse',
              'IEU_ERPMaster.AddPagosGrupoInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddPagosGrupoInfoResult;
        }
        public String AddPagosInscripcionInfo(String usuario,String pwd,IEU_ERPMaster.ArrayOfPagosInscripcionInfo PagosInscripcionInfo) {
            IEU_ERPMaster.AddPagosInscripcionInfo_element request_x = new IEU_ERPMaster.AddPagosInscripcionInfo_element();
            request_x.usuario = usuario;
            request_x.pwd = pwd;
            request_x.PagosInscripcionInfo = PagosInscripcionInfo;
            IEU_ERPMaster.AddPagosInscripcionInfoResponse_element response_x;
            Map<String, IEU_ERPMaster.AddPagosInscripcionInfoResponse_element> response_map_x = new Map<String, IEU_ERPMaster.AddPagosInscripcionInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/AddPagosInscripcionInfo',
              'http://tempuri.org/',
              'AddPagosInscripcionInfo',
              'http://tempuri.org/',
              'AddPagosInscripcionInfoResponse',
              'IEU_ERPMaster.AddPagosInscripcionInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddPagosInscripcionInfoResult;
        }
        public String AddCandidatoInfo(String usuario,String pwd,IEU_ERPMaster.ArrayOfCandidatoInfo CandidatoInfo) {
            IEU_ERPMaster.AddCandidatoInfo_element request_x = new IEU_ERPMaster.AddCandidatoInfo_element();
            request_x.usuario = usuario;
            request_x.pwd = pwd;
            request_x.CandidatoInfo = CandidatoInfo;
            IEU_ERPMaster.AddCandidatoInfoResponse_element response_x;
            Map<String, IEU_ERPMaster.AddCandidatoInfoResponse_element> response_map_x = new Map<String, IEU_ERPMaster.AddCandidatoInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/AddCandidatoInfo',
              'http://tempuri.org/',
              'AddCandidatoInfo',
              'http://tempuri.org/',
              'AddCandidatoInfoResponse',
              'IEU_ERPMaster.AddCandidatoInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddCandidatoInfoResult;
        }
        public String Hola(String nombre) {
            IEU_ERPMaster.Hola_element request_x = new IEU_ERPMaster.Hola_element();
            request_x.nombre = nombre;
            IEU_ERPMaster.HolaResponse_element response_x;
            Map<String, IEU_ERPMaster.HolaResponse_element> response_map_x = new Map<String, IEU_ERPMaster.HolaResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/Hola',
              'http://tempuri.org/',
              'Hola',
              'http://tempuri.org/',
              'HolaResponse',
              'IEU_ERPMaster.HolaResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.HolaResult;
        }
        public String AddGrupoInfo(String usuario,String pwd,IEU_ERPMaster.ArrayOfGrupoInfo GrupoInfo) {
            IEU_ERPMaster.AddGrupoInfo_element request_x = new IEU_ERPMaster.AddGrupoInfo_element();
            request_x.usuario = usuario;
            request_x.pwd = pwd;
            request_x.GrupoInfo = GrupoInfo;
            IEU_ERPMaster.AddGrupoInfoResponse_element response_x;
            Map<String, IEU_ERPMaster.AddGrupoInfoResponse_element> response_map_x = new Map<String, IEU_ERPMaster.AddGrupoInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/AddGrupoInfo',
              'http://tempuri.org/',
              'AddGrupoInfo',
              'http://tempuri.org/',
              'AddGrupoInfoResponse',
              'IEU_ERPMaster.AddGrupoInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddGrupoInfoResult;
        }
        public String AddBecasInfo(String usuario,String pwd,IEU_ERPMaster.ArrayOfBecasInfo BecasInfo) {
            IEU_ERPMaster.AddBecasInfo_element request_x = new IEU_ERPMaster.AddBecasInfo_element();
            request_x.usuario = usuario;
            request_x.pwd = pwd;
            request_x.BecasInfo = BecasInfo;
            IEU_ERPMaster.AddBecasInfoResponse_element response_x;
            Map<String, IEU_ERPMaster.AddBecasInfoResponse_element> response_map_x = new Map<String, IEU_ERPMaster.AddBecasInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/AddBecasInfo',
              'http://tempuri.org/',
              'AddBecasInfo',
              'http://tempuri.org/',
              'AddBecasInfoResponse',
              'IEU_ERPMaster.AddBecasInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddBecasInfoResult;
        }
    }
}