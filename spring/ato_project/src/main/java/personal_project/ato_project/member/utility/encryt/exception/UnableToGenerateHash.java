package personal_project.ato_project.member.utility.encryt.exception;

public class UnableToGenerateHash extends RuntimeException{

    public UnableToGenerateHash(String message){
        super(message);
    }

    public UnableToGenerateHash(String message, Throwable cause){
        super(message, cause);
    }
}
