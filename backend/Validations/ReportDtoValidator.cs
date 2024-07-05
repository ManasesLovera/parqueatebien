using backend.DTOs;
using FluentValidation;
namespace backend.Validations;

public class ReportDtoValidator : AbstractValidator<ReportDto>
{
    public ReportDtoValidator()
    {
        RuleFor(x => x.LicensePlate)
            .NotNull().WithMessage("La placa es requerida.")
            .NotEmpty().WithMessage("La placa no puede estar vacía.")
            .Matches(@"^[A-Z]{1,2}[0-9]{6}$").WithMessage("El formato de la placa es inválido. Debe tener 1 a dos letras mayusculas y 6 numeros.");

        RuleFor(x => x.RegistrationDocument)
            .NotNull().WithMessage("La matricula es requerida.")
            .NotEmpty().WithMessage("La matricula no puede estar vacía.")
            .Matches(@"^[0-9]{9}$").WithMessage("El formato de la matricula es inválido. Debe contener 9 dígitos numéricos.");

        RuleFor(x => x.VehicleType).NotNull().NotEmpty().WithMessage("El tipo es requerido.");
        RuleFor(x => x.VehicleColor).NotNull().NotEmpty().WithMessage("El color es requerido.");
        RuleFor(x => x.Model).NotNull().NotEmpty().WithMessage("El modelo es requerido.");
        RuleFor(x => x.Year).NotNull().NotEmpty().WithMessage("El año es requerido.");
        RuleFor(x => x.ReportedBy).NotNull().NotEmpty().WithMessage("El reportado por es requerido.");

        RuleFor(x => x.Lat)
            .NotNull().NotEmpty().WithMessage("Latitud es requerida.")
            .Must(BeDecimal!).WithMessage("Latitud debe ser un número decimal válido.");

        RuleFor(x => x.Lon)
            .NotNull().NotEmpty().WithMessage("Longitud es requerida.")
            .Must(BeDecimal!).WithMessage("Longitud debe ser un número decimal válido.");
    }
    private bool BeDecimal(string value)
    {
        return decimal.TryParse(value, out _);
    }
}