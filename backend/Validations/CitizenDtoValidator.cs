using backend.DTOs;
using FluentValidation;

namespace backend.Validations;

public class CitizenDtoValidator : AbstractValidator<CitizenDto>
{
    public CitizenDtoValidator()
    {
        RuleFor(x => x.GovernmentId)
            .NotNull().NotEmpty().WithMessage("Falta la placa")
            .Matches(@"^[0-9]{11}$").WithMessage("La placa no es valida, debe contener 11 numeros");

        RuleFor(x => x.Name)
            .NotEmpty().NotNull().WithMessage("Falta el nombre");

        RuleFor(x => x.Lastname)
            .NotEmpty().NotNull().WithMessage("Falta el apellido");

        RuleFor(x => x.Email)
            .NotEmpty().NotNull().WithMessage("Falta el correo");

        RuleFor(x => x.Status)
           .NotNull().WithMessage("Falta el estado");

        RuleFor(x => x.Password)
            .NotEmpty().NotEmpty().NotNull().WithMessage("Falta la contraseña");

        RuleFor(x => x.Vehicles)
            .NotNull().WithMessage("Falta el vehiculo.");
    }
}
